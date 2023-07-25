import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {}

class Item {
  String? url;
  Color? color;
  int? crossAxisCellCount;
  int? mainAxisCellCount;
  bool networkImage;

  Item(
      {this.url,
      this.color,
      this.crossAxisCellCount,
      this.mainAxisCellCount,
      this.networkImage = false});
}

class highLightClass {
  String? url, name;
  Color? color;

  highLightClass({this.url, this.color, this.name});
}
