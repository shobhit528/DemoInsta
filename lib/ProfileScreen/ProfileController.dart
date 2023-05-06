import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxList<highLightClass> HeighLightlist = <highLightClass>[
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
  ].obs;

  RxList<Item> CardlistItem = <Item>[
    Item(
        url: "assets/images/image_profile.png",
        crossAxisCellCount: 1,
        mainAxisCellCount: 2,
        color: Colors.pinkAccent.shade400),
    Item(
        url: "assets/images/image_two.png",
        crossAxisCellCount: 1,
        mainAxisCellCount: 3,
        color: Color.fromRGBO(255, 123, 107, 1)),
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
        url: "assets/images/image_three.png",
        crossAxisCellCount: 1,
        mainAxisCellCount: 1,
        color: Colors.blueAccent.shade100),
    Item(
        url: "assets/images/image_profile.png",
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        color: Colors.deepPurple.shade200),
  ].obs;

}

class Item {
  String? url;
  Color? color;
  int? crossAxisCellCount;
  int? mainAxisCellCount;

  Item({this.url, this.color, this.crossAxisCellCount, this.mainAxisCellCount});
}

class highLightClass {
  String? url, name;
  Color? color;

  highLightClass({this.url, this.color, this.name});
}

Widget CustomHightlightView(String? url,
    name, Color? color) =>
    SizedBox(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(url!,height: 50,width: 50,),
                ),
              ),
              name != null ? Flexible(child: Text(name!,style: TextStyle( fontSize: 12),)) : SizedBox(),
            ]));