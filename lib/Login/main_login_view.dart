import 'dart:io';

import 'package:chatapp/Login/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoginScreen.dart';

class MainLoginView extends StatelessWidget {
  const MainLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Flexible(
                child: Center(
              child: Text(
                "Welcome to InstaClone",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            )),
            Flexible(
                child: buttonWidget("Social Login",
                    backgroundColor: Colors.lightBlue,
                    onTap: () => context
                        .read<LoginBloc>()
                        .navigateToSubScreens(StateEnum.stateLoginSocial))),
            Flexible(
                child: buttonWidget("OTP Login",
                    backgroundColor: Colors.blueGrey,
                    onTap: () => context
                        .read<LoginBloc>()
                        .navigateToSubScreens(StateEnum.stateLoginMobile))),
            Visibility(
                visible: Platform.isIOS,
                child: Flexible(
                    child: buttonWidget("Apple Login",
                        backgroundColor: Colors.black,
                        onTap: () => context
                            .read<LoginBloc>()
                            .navigateToSubScreens(StateEnum.stateLoginApple)))),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Expanded(child: buttonWidget("App Icon One",
                    backgroundColor: Colors.orangeAccent,
                    onTap: () => context.read<LoginBloc>().changeIconOne())),
                Expanded(child: buttonWidget("App Icon Two",
                    backgroundColor: Colors.pinkAccent,
                    onTap: () => context.read<LoginBloc>().changeIconTwo()))
              ]),
            ),

          ]),
    );
  }

  Widget buttonWidget(String text,
          {void Function()? onTap, Color? backgroundColor}) =>
      Container(
        margin: const EdgeInsets.all(10),
        height: 50,
        child: SizedBox.expand(
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(backgroundColor ?? Colors.black),
              ),
              onPressed: onTap,
              child: Text(
                text.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )),
        ),
      );
}
