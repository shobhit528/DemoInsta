import 'dart:async';

import 'package:chatapp/UtilsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../HomeScreen/ViewStatus.dart';
import '../ProfileController.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialEvent>(methodProfileInitialEvent);
    on<LogoutClickEvent>(methodLogoutClickEvent);
    on<FollowClickEvent>(methodFollowClickEvent);
    on<MessageClickEvent>(methodMessageClickEvent);
    on<PhotosClickEvent>(methodPhotosClickEvent);
    on<VideosClickEvent>(methodVideosClickEvent);
    on<FollowerClickEvent>(methodFollowerClickEvent);
    on<FollowingClickEvent>(methodFollowingClickEvent);
    on<HighlightsClickEvent>(methodHighlightsClickEvent);
    on<AddHighlightsClickEvent>(methodAddHighlightsClickEvent);
  }

  FutureOr<void> methodLogoutClickEvent(LogoutClickEvent event,
      Emitter<ProfileState> emit) {
    print("LogoutClicked");
    emit(ProfileLogoutNavigateState());
  }

  FutureOr<void> methodHighlightsClickEvent(HighlightsClickEvent event,
      Emitter<ProfileState> emit) {
    var isNetworkImage=event.url?.contains("http") ?? false;
    showDialog(
      context: Get.context!,
      builder: (context) => StatusScreen(
          imageUrl: isNetworkImage? event.url! : "https://picsum.photos/1024/1024".random()),
    );
  }

  FutureOr<void> methodFollowingClickEvent(FollowingClickEvent event,
      Emitter<ProfileState> emit) {
    print("FollowingClicked");
  }

  FutureOr<void> methodFollowerClickEvent(FollowerClickEvent event,
      Emitter<ProfileState> emit) {
    print("FollowerClicked");
  }

  FutureOr<void> methodFollowClickEvent(FollowClickEvent event,
      Emitter<ProfileState> emit) {
    print("FollowClicked");
    emit(ProfileFollowNavigateState());
  }

  FutureOr<void> methodVideosClickEvent(VideosClickEvent event,
      Emitter<ProfileState> emit) {
    print("VideosClicked");
  }

  FutureOr<void> methodMessageClickEvent(MessageClickEvent event,
      Emitter<ProfileState> emit) {
    print("MessageClicked");
    emit(ProfileMessageNavigateState());
  }

  FutureOr<void> methodPhotosClickEvent(PhotosClickEvent event,
      Emitter<ProfileState> emit) {
    print("PhotosClicked");
  }

  FutureOr<void> methodAddHighlightsClickEvent(AddHighlightsClickEvent event,
      Emitter<ProfileState> emit) {
    print("AddhighlightClicked");
  }

  Future<FutureOr<void>> methodProfileInitialEvent(ProfileInitialEvent event,
      Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    List<Item> CardlistItem = <Item>[
      Item(
          url: "".randomImageWithOutDimention(hightScale: 2),
          networkImage: true,
          crossAxisCellCount: 1,
          mainAxisCellCount: 2,
          color: Colors.pinkAccent.shade400),
      Item(
          url: "assets/images/image_two.png",
          crossAxisCellCount: 1,
          mainAxisCellCount: 3,
          color: AppThemeColor),
      Item(
          url: "assets/images/image_three.png",
          crossAxisCellCount: 1,
          mainAxisCellCount: 2,
          color: Colors.teal.shade100),
      Item(
          url: "assets/images/image_two.png",
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          color: Colors.green.shade200),
      Item(
          url: "".randomImageWithOutDimention(),
          networkImage: true,
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          color: Colors.blueAccent.shade100),
      Item(
          url: "assets/images/image_profile.png",
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          color: Colors.deepPurple.shade200),
      Item(
          url: "".randomImageWithOutDimention(),
          networkImage: true,
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          color: Colors.pinkAccent.shade400),
      Item(
          url: "".randomImageWithOutDimention(),
          networkImage: true,
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          color: const Color.fromRGBO(255, 123, 107, 1)),
    ];

    List<highLightClass> HeighLightlist = <highLightClass>[
      highLightClass(
          name: "Vacations",
          url: "assets/images/image_two.png",
          color: Colors.teal.shade100),
      highLightClass(
          name: "Parties",
          url: "assets/images/image_three.png",
          color: Colors.green.shade200),
      highLightClass(
          name: "LifeStyles",
          url: "assets/images/image_profile.png",
          color: Colors.blueAccent.shade100)
    ];
    await Future.delayed(const Duration(seconds: 1));
    emit(ProfileLoadSuccessState(CardlistItem, HeighLightlist));
  }
}


class ApiCall extends GetConnect {
  Future<dynamic> getImage({String gender = "female"}) =>
      get("https://xsgames.co/randomusers/avatar.php?g=$gender");

}