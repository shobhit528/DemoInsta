import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

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
  LoginBloc({Key, required this.context}) : super(Key);

  Artboard? teddyboard;
  late String vId;
  TextEditingController controller = TextEditingController();
  StateMachineController? stateMachineController;
  BuildContext context;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? NumLook;

  _onRiveInit() {
    // rootBundle.load('assets/images/login_screen.riv').then((data) {
    //   final file = RiveFile.import(data);
    //   final artboard = file.mainArtboard;
    //   stateMachineController =
    //       StateMachineController.fromArtboard(artboard, 'Login Machine');
    //   if (stateMachineController != null) {
    //     artboard.addController(stateMachineController!);
    //   }
    //
    //   stateMachineController?.inputs.forEach((element) {
    //     print(element);
    //     debugPrint(element.runtimeType.toString());
    //     debugPrint("Name====>  ${element.name}");
    //   });
    //   stateMachineController?.inputs.forEach((element) {
    //     if (element.name == "trigSuccess") {
    //       successTrigger = element as SMITrigger;
    //     }
    //     if (element.name == "trigFail") {
    //       failTrigger = element as SMITrigger;
    //     }
    //     if (element.name == "isHandsUp") {
    //       isHandsUp = element as SMIBool;
    //     }
    //     if (element.name == "isChecking") {
    //       isChecking = element as SMIBool;
    //     }
    //     if (element.name == "numlook") {
    //       NumLook = element as SMINumber;
    //     }
    //   });
    //   teddyboard = artboard;
    // });
    // emit(teddyboard);
  }

  void moveEyes(String val) => NumLook?.change(val.length.toDouble());
  void handsUp() => isHandsUp?.change(true);

  void textFieldLookUp() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    NumLook?.change(0);
    emit(isHandsUp);
    emit(isChecking);
    emit(NumLook);
  }

  void loginHit() {
    isHandsUp?.change(false);
    isChecking?.change(false);
    if(controller.text
        .toString()
        .trim()
        .length >= 10 && controller.text
        .toString()
        .trim()
        .isNotEmpty){
      successTrigger?.fire();
    }else{
      failTrigger?.fire();
    }
    emit(isHandsUp);
    emit(isChecking);
    emit(successTrigger);
    emit(failTrigger);
  }

  void initRive() => _onRiveInit();

  void verifyAuth() async {
    loginHit();
    if (controller.text
        .toString()
        .trim()
        .isEmpty) {
      Get.snackbar("Wrong Number", "Please enter valid mobile number");
    } else if (controller.text
        .toString()
        .trim()
        .length < 10) {
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
