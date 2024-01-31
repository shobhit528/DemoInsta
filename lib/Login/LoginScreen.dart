import 'package:chatapp/Login/LoginController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoginView.dart';
import 'main_login_view.dart';

enum StateEnum {
  stateLoginMobile,
  stateLoginApple,
  stateLoginSocial,
  stateNone
}

class LoginScreen extends StatelessWidget {
  final StateEnum loginScreen;

  const LoginScreen({super.key, this.loginScreen = StateEnum.stateNone});

  @override
  Widget build(BuildContext context) {

    switch (loginScreen) {
      case StateEnum.stateLoginMobile:
        return LoginView();
      case StateEnum.stateLoginApple :
        return LoginView();
      case StateEnum.stateLoginSocial:return LoginView();
      default:
        return const MainLoginView();
    }
  }
}
