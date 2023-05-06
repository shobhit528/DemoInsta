import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsttech/Get_IT.dart';
import 'package:tsttech/OTP/OTPController.dart';

import '../main.dart';
import 'OTPInput.dart';

class OTPView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                "assets/images/main_image.png",
                height: 200,
                width: 200,
              ),
              height: 300,
              width: 300,
            ),
            Text("OTP",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Container(
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     shape: BoxShape.rectangle,
              //     color: Colors.grey.shade300),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OtpInput(getIt<OTPController>().One, true),
                  OtpInput(getIt<OTPController>().Two, false),
                  OtpInput(getIt<OTPController>().Three, false),
                  OtpInput(getIt<OTPController>().Four, false),
                  OtpInput(getIt<OTPController>().Five, false),
                  OtpInput(getIt<OTPController>().Six, false)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: SizedBox(
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    onPressed: () => getIt<OTPController>().signInWithPhoneNumber(),
                    child: Text("Verify")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
