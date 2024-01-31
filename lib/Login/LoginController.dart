import 'dart:collection';

import 'package:chatapp/Login/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dynamic_icon_flutter/dynamic_icon_flutter.dart';
import 'package:get/get.dart';

import '../OTP/OTPScreen.dart';
import '../UiUtils/BottomTabView.dart';
import '../UtilsController.dart';

abstract class VerifyAuth {
  onVerificationCompleted(PhoneAuthCredential credential);

  onCodeSent(String verificationId, int? resendToken);

  codeAutoRetrievalTimeout(String verificationId);

  verificationFailed(FirebaseAuthException e);
}

class IsolateModel {
  IsolateModel(this.iteration, this.multiplier);

  final int iteration;
  final int multiplier;
}

class LoginBloc extends Cubit implements VerifyAuth {
  LoginBloc({Key, required this.context}) : super(Key);

  late String vId;
  TextEditingController controller = TextEditingController();
  BuildContext context;
  HashMap map = HashMap();

  void verifyAuth() async {
    if (controller.text.toString().trim().isEmpty) {
      Get.snackbar("Wrong Number", "Please enter valid mobile number");
    } else if (controller.text.toString().trim().length < 10) {
      Get.snackbar("Wrong Number", "Please enter valid mobile number");
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91 ${controller.text.toString().trim()}',
        verificationCompleted: onVerificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    }
  }

  @override
  codeAutoRetrievalTimeout(String verificationId) {
    Get.snackbar("ee", verificationId);
  }

  @override
  onCodeSent(String verificationId, int? resendToken) {
    vId = verificationId;
    Get.to(() => const OTPScreen());
  }

  @override
  onVerificationCompleted(PhoneAuthCredential credential) {
    Get.snackbar("e.code", credential.toString());
  }

  @override
  verificationFailed(FirebaseAuthException e) {
    Get.snackbar(e.code, e.message.toString());
    print(e.message);
  }

  void navigateToSubScreens([StateEnum? state]) {
    switch (state) {
      case StateEnum.stateLoginMobile:
        Get.to(
            () => const LoginScreen(loginScreen: StateEnum.stateLoginMobile));
        break;
      case StateEnum.stateLoginApple:
        callNativeLogin(type: "apple").then((value) {
          UtilsController().setLoggedin(true);
          Get.offAll(() => BottomTabView());
        });
        break;
      case StateEnum.stateLoginSocial:
        callNativeLogin(type: "google").then((value) {
          UtilsController().setLoggedin(true);
          Get.offAll(() => BottomTabView());
        });
        break;
      default:
        Get.to(
            () => const LoginScreen(loginScreen: StateEnum.stateLoginSocial));
        break;
    }
  }

  Future<String> callNativeCode() async {
    try {
      var data = await const MethodChannel("com.third_party_login")
          .invokeMethod('messageFunction');
      return data;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }

  Future changeIconOne() async {
    const List<String> list = ["icon_1","icon_2", "MainActivity"];
    DynamicIconFlutter.setIcon(icon: 'icon_1', listAvailableIcon: list);

  }
  Future changeIconTwo() async {
    const List<String> list = ["icon_1","icon_2", "MainActivity"];
    DynamicIconFlutter.setIcon(icon: 'icon_2', listAvailableIcon: list);

  }

  Future<bool> callNativeLogin({String? type}) async {
    switch (type) {
      case "apple":
        {
          try {
            Map<dynamic, dynamic> data =
                await const MethodChannel("com.third_party_login")
                    .invokeMethod('appleLoginFunction');
            map.assignAll(data);
            return true;
          } on PlatformException catch (e) {
            print("Failed to Invoke: '${e.message}'.");
            return false;
          }
        }

      case "google":
        {
          try {
            Map<dynamic, dynamic> data =
                await const MethodChannel("com.third_party_login")
                    .invokeMethod('googleLoginFunction');
            map.assignAll(data);
            return true;
          } on PlatformException catch (e) {
            print("Failed to Invoke: '${e.message}'.");
            return false;
          }
        }
      default:
        return false;
    }
  }
}
