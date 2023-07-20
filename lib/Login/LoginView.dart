import 'package:chatapp/Get_IT.dart';
import 'package:chatapp/UtilsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'LoginController.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: SizedBox(
                height: 300,
                width: 300,
                child: Image.network(
                  "".randomImage(200, 200),
                ),
              ),
            ),
            const Flexible(
              child: Text("Login",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            Flexible(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      color: Colors.grey.shade300),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextFormField(
                    controller:context.read<LoginBloc>().controller,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Mobile Number",
                        contentPadding: EdgeInsets.only(left: 10)),
                  )),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 40),
                child: SizedBox(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber),
                      ),
                      onPressed: () => context.read<LoginBloc>().verifyAuth(),
                      child: const Text("Send OTP")),
                ),
              ),
            ),
            /*Flexible(
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.amber),
                      ),
                      onPressed: () => getIt<LoginController>().asyncTask(),
                      child: Text("Test network connection with postgres")),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
