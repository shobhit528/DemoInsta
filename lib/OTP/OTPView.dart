import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:chatapp/Get_IT.dart';
import 'package:chatapp/OTP/OTPController.dart';

import '../main.dart';
import 'OTPInput.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<OTPBloc>().One.clear();
    context.read<OTPBloc>().Two.clear();
    context.read<OTPBloc>().Three.clear();
    context.read<OTPBloc>().Four.clear();
    context.read<OTPBloc>().Five.clear();
    context.read<OTPBloc>().Six.clear();
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset(
                "assets/images/main_image.png",
                height: 200,
                width: 200,
              ),
            ),
            const Text("OTP",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Container(
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     shape: BoxShape.rectangle,
              //     color: Colors.grey.shade300),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OtpInput(context.read<OTPBloc>().One, true),
                  OtpInput(context.read<OTPBloc>().Two, false),
                  OtpInput(context.read<OTPBloc>().Three, false),
                  OtpInput(context.read<OTPBloc>().Four, false),
                  OtpInput(context.read<OTPBloc>().Five, false),
                  OtpInput(context.read<OTPBloc>().Six, false)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: SizedBox(
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    onPressed: () => context.read<OTPBloc>().signInWithPhoneNumber(),
                    child: const Text("Verify")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
