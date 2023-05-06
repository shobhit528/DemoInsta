import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tsttech/Get_IT.dart';
import 'package:tsttech/Login/LoginController.dart';
import 'package:tsttech/UtilsController.dart';
import 'package:tsttech/main.dart';

import '../BottomTabView.dart';

class OTPController extends GetxController implements VerifyAuth {
  final TextEditingController One = TextEditingController();
  final TextEditingController Two = TextEditingController();
  final TextEditingController Three = TextEditingController();
  final TextEditingController Four = TextEditingController();
  final TextEditingController Five = TextEditingController();
  final TextEditingController Six = TextEditingController();

  // void VerifyCode() {
  //   Get.to(() => BottomTabView());
  // }
  String makeOtp() {
    return One.text.toString().trim() +
        Two.text.toString().trim() +
        Three.text.toString().trim() +
        Four.text.toString().trim() +
        Five.text.toString().trim() +
        Six.text.toString().trim();
  }

  void signInWithPhoneNumber({String? verificationId, String? otptext}) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: getIt<LoginController>().vId, smsCode: makeOtp());
      final User? user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;


      Get.snackbar("Successfully signed in UID: ${user!.uid}",
          "Successfully signed in UID: ${user.uid}");
      // callback!(true);
      UtilsController().setLoggedin(true);
      Get.offAll(() => BottomTabView());
    } catch (e) {
      Get.snackbar("Failed to sign in: " + e.toString(),
          "Failed to sign in: " + e.toString());
      // callback!(false);
    }
  }

  @override
  codeAutoRetrievalTimeout(String verificationId) {
    print("object");
  }

  @override
  onCodeSent(String verificationId, int? resendToken) {
    print("object");
  }

  @override
  onVerificationCompleted(PhoneAuthCredential credential) {
    print("object");
  }

  @override
  verificationFailed(FirebaseAuthException e) {
    print("object");
  }
}
