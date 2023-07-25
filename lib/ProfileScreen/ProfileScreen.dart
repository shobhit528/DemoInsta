import 'package:chatapp/ProfileScreen/ProfileView.dart';
import 'package:chatapp/ProfileScreen/profile_bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../Get_IT.dart';
import '../HomeScreen/AnimationClass.dart';
import '../Login/LoginScreen.dart';
import '../UtilsController.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileBloc _profileBloc = ProfileBloc();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // _profileBloc.add(event)
    _profileBloc.add(ProfileInitialEvent());
    return BlocConsumer<ProfileBloc, ProfileState>(
        bloc: _profileBloc,
        listenWhen: (previous, current) => current is ProfileActionState,
        buildWhen: (previous, current) => current is! ProfileActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProfileLoadingState:
              return Scaffold(
                  body: FlyingAnimation(
                circleColor: Colors.black54,
                bgColor: Colors.transparent,
              ).makeSizedCenter(
                      height: 100.mobileFont(), width: 100.mobileFont()));
            case ProfileLoadSuccessState:
              return ProfileView(_profileBloc);
            case ProfileErrorState:
              return const Scaffold(body: Center(child: Text("error")));
          }
          return const SizedBox();
        },
        listener: (context, state) {
          switch (state.runtimeType) {
            case ProfileLogoutNavigateState:
              getIt<UtilsController>().setLoggedin(false);
              Get.offAll(() => LoginScreen());
              break;

            case ProfileFollowNavigateState:
              Get.snackbar("Follow", "Follow option clicked",
                  backgroundColor: Colors.redAccent.shade400);
              break;

            case ProfileMessageNavigateState:
              Get.snackbar("Message", "Message option clicked",
                  backgroundColor: Colors.green);
              break;
            case ProfileInitial:
              break;
            case ProfileLoadSuccessState:
              break;
          }
        });
  }
}

extension StyleAnimate on FlyingAnimation {
  Center makeCenter() => Center(child: this);

  Center makeSizedCenter({double? height, double? width}) =>
      Center(child: SizedBox(height: height, width: width, child: this));
}
