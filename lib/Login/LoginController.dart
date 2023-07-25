import 'package:chatapp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../OTP/OTPScreen.dart';

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
  LoginBloc({Key,required this.context}) : super(Key);

  BuildContext context;
  late String vId;
  TextEditingController controller = TextEditingController();

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
}
