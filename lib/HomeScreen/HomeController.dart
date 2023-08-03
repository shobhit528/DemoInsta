import 'package:chatapp/Animations/AnimationClass.dart';
import 'package:chatapp/HomeScreen/ViewStatus.dart';
import 'package:chatapp/UI_Utils.dart';
import 'package:chatapp/UtilsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rnd/rnd.dart';

class HomeBloc extends Cubit {
  HomeBloc({Key, required this.context}) : super(Key);
  BuildContext context;
  TextEditingController controller = TextEditingController();

  RxInt currentClick = 10.obs;
  RxList<User> list = <User>[
    User("Sam",
        imageUrl: "assets/images/image_three.png",
        color: Colors.blueAccent.shade100),
    User("Jholly",
        imageUrl: "assets/images/image_profile.png",
        color: Colors.green.shade200),
    User("Walaam",
        imageUrl: "assets/images/image_two.png", color: Colors.teal.shade100),
    User("Willy",
        imageUrl: "assets/images/image_three.png",
        color: Colors.blueAccent.shade100),
    User("Kristine",
        imageUrl: "assets/images/image_two.png",
        color: Colors.blueAccent.shade100)
  ].obs;

  bool isLiked(int index) => feedList[index].isLiked;
  List<feedCardClass> feedList = <feedCardClass>[
    feedCardClass(
        feedImage: "https://picsum.photos/2048/2048".randomBlur(),
        image: "https://picsum.photos/50/50".random(),
        name: "Dianna Russell",
        title: "St. Utica",
        likes: "10",
        messages: "11",
        shared: "10",
        saved: "19"),
    feedCardClass(
        feedImage: "https://picsum.photos/2048/2048".randomBlur(),
        image: "https://picsum.photos/50/50".random(),
        name: "Anna Rull",
        title: "St. Bosenberg",
        likes: rnd.getInt(0, 100).toString(),
        messages: rnd.getInt(0, 100).toString(),
        shared: rnd.getInt(0, 100).toString(),
        saved: rnd.getInt(0, 100).toString()),
    feedCardClass(
        feedImage: "https://picsum.photos/2048/2048".randomBlur(),
        image: "https://picsum.photos/50/50".random(),
        name: "Rustom Fiend",
        title: "Giant Bukerberg",
        likes: rnd.getInt(0, 100).toString(),
        messages: rnd.getInt(0, 100).toString(),
        shared: rnd.getInt(0, 100).toString(),
        saved: rnd.getInt(0, 100).toString())
  ];

  onClickStatus(User user) => showDialog(
        context: Get.context!,
        builder: (context) => StatusScreen(
            imageUrl:
                user.statusImage ?? "https://picsum.photos/1024/1024".random()),
      );

  onCardClick(feedCardClass e) {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        switch (feedList.indexOf(e) + 1) {
          case 1:
            return const BouncingLine();
          case 2:
            return const AnimationClass();
          case 3:
            return const BouncingBall(type: 1);
          case 4:
            return const SpinningAnimation();
          default:
            return Container();
        }
      },
    );
  }

  onButtonClick(feedCardClass e) {
    currentClick.value = feedList.indexOf(e);
    e.isLiked = true;
    feedList[currentClick.value] = e;
    feedList = feedList;
    Future.delayed(const Duration(seconds: 5), () {
      currentClick.value = 10;
    });
  }

  onSendClick(feedCardClass e) => UiUtils().showDialogSending(e,context);
}

class User {
  String name;
  String? imageUrl = "https://picsum.photos/50/50".random();
  Color? color;
  String? statusImage;
  bool networkImage;

  User(this.name,
      {this.imageUrl, this.color, this.statusImage, this.networkImage = false});
}

class feedCardClass {
  String name;
  String image;
  String title;
  String feedImage;
  String messages;
  String likes;
  String shared;
  String saved;
  bool isLiked;

  feedCardClass(
      {this.name = "",
      this.title = "",
      this.image = "",
      this.feedImage = "",
      this.likes = "",
      this.messages = "",
      this.shared = "",
      this.saved = "",
      this.isLiked = true});
}
