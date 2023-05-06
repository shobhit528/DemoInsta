import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tsttech/Get_IT.dart';
import 'package:tsttech/main.dart';

import 'LoginController.dart';

class LoginView extends StatelessWidget {

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
            Text("Login",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    color: Colors.grey.shade300),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextFormField(
                  controller: getIt<LoginController>().controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Mobile Number",
                      contentPadding: EdgeInsets.only(left: 10)),
                )),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: SizedBox(
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    onPressed: () => getIt<LoginController>().verifyAuth(),
                    child: Text("Send OTP")),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: SizedBox(
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    onPressed: () => getIt<LoginController>().asyncTask(),
                    child: Text("Test network connection with postgres")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
