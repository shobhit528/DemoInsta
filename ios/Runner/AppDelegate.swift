import UIKit
import AuthenticationServices
import Flutter
import FirebaseCore
import GoogleSignIn
import FirebaseAuth
import CryptoKit



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    override func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
      
      let firebaseAuth = Auth.auth()
      do {
        try firebaseAuth.signOut()
      } catch let signOutError as NSError {
        print("Error signing out: %@", signOutError)
      }
    
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let deviceChannel = FlutterMethodChannel(name: "com.third_party_login",
                                                       binaryMessenger: controller.binaryMessenger)
      prepareMethodHandler(deviceChannel: deviceChannel)



      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    private func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
            deviceChannel.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                if call.method == "googleLoginFunction" {
                    self.proceedLogin(result: result)
                } else if call.method == "appleLoginFunction" {
                    self.appleLogin(result: result)
                }
                else {
                    result(FlutterMethodNotImplemented)
                    return
                }
            })
        }
    private func appleLogin(result: @escaping FlutterResult) {
        if #available(iOS 13.0, *) {
               let provider = ASAuthorizationAppleIDProvider()
               let request = provider.createRequest()
               request.requestedScopes = [.fullName, .email]
               
               let authorizationController = ASAuthorizationController(authorizationRequests: [request])
               authorizationController.delegate = self
               authorizationController.presentationContextProvider = self
               authorizationController.performRequests()
           } else {
               // Handle iOS version below 13.0 where Apple Sign-In is not available
               result(FlutterError(code: "APPLE_SIGN_IN_NOT_AVAILABLE", message: "Apple Sign-In is not available on this iOS version.", details: nil))
           }
    }
    private func proceedLogin(result: @escaping FlutterResult) {
        var call:FlutterResult = result
        
        var map: [String: String] = [:]
       guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self.window.rootViewController!) { [unowned self] result, error in
            guard error == nil else {
                print("error")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("null")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print("Firebase Auth error: \(error.localizedDescription)")
                    return
                }else {
                    if let user = authResult?.user {
                        map["family_name"] = "";
                        map["id_token"] = user.uid;
                        map["given_name"] = user.displayName ?? "N/A";
                        map["name"] = user.displayName ?? "N/A";
                        map["email"] = user.email ?? "N/A"
                        call(map)
                    } else {
                            print("User information not available")
                    }
                }
                
            }
        
        }
        
        }
 }

@available(iOS 13.0, *)
extension AppDelegate: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Perform necessary tasks with the Apple ID credential data
            // Example: Get user identifier, email, full name, etc.
            // Then send the data back to Flutter using the `result` parameter
//            result("User data from Apple Sign-In")
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // Return the window to present the Apple Sign-In UI
        return self.window!
    }
}
