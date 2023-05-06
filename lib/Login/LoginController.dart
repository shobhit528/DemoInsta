import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tsttech/main.dart';

import '../OTP/OTPScreen.dart';

class LoginController extends GetxController implements VerifyAuth {
  late String vId;
  TextEditingController controller = new TextEditingController();

  void verifyAuth() async {
    if (controller.text.toString().trim().isEmpty) {
      Get.snackbar("Wrong Number", "Please enter valid mobile number");
    } else if (controller.text.toString().trim().length < 10) {
      Get.snackbar("Wrong Number", "Please enter valid mobile number");
    } else
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91 ${controller.text.toString().trim()}',
        verificationCompleted: onVerificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
  }

  void asyncTask() async {
    // Isolate.spawn<IsolateModel>(heavyTask, IsolateModel(355000, 50000000));
    // Isolate.spawn<IsolateModel>(heavyTask2, IsolateModel(1, 1));
    // heavyTask2();

    print("sad");
    print(Provider.of<DemoProvider>(Get.context!, listen: false).DemoAppName);
    Provider.of<DemoProvider>(Get.context!, listen: false).DemoAppName =
        "New Name";
    print(Provider.of<DemoProvider>(Get.context!, listen: false).DemoAppName);
  }

  void heavyTask(IsolateModel model) {
    int total = 0;

    /// Performs an iteration of the specified count
    for (int i = 1; i < model.iteration; i++) {
      /// Multiplies each index by the multiplier and computes the total
      total += (i * model.multiplier);
    }

    print("FINAL TOTAL: $total");
  }

  void heavyTask2({IsolateModel? model}) async {
    // var url = 'localhost/test/5432';
    // var client = PostgrestClient(url);
    // var response = await client.from('person').select().execute();
    // print(response);
  }

  @override
  codeAutoRetrievalTimeout(String verificationId) {
    Get.snackbar("ee", verificationId);
  }

  @override
  onCodeSent(String verificationId, int? resendToken) {
    vId = verificationId;
    Get.to(() => OTPScreen());
  }

  @override
  onVerificationCompleted(PhoneAuthCredential credential) {
    Get.snackbar("e.code", credential.toString());
  }

  @override
  verificationFailed(FirebaseAuthException e) {
    Get.snackbar(e.code, e.message.toString());
  }
}

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
