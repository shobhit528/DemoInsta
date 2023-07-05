import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsttech/HomeScreen/ViewStatus.dart';

class HomeController extends GetxController {
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

  onClickStatus(User user) => showDialog(
        context: Get.context!,
        builder: (context) =>  StatusScreen(imageUrl:user.imageUrl),
      );


}

class User {
  String name;
  String imageUrl;
  Color? color;

  User(this.name, {this.imageUrl = "https://picsum.photos/50/50", this.color});
}
