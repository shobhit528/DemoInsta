import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsttech/HomeScreen/HomeScreen.dart';
import 'package:tsttech/ProfileScreen/ProfileScreen.dart';

class BottomTabView extends StatelessWidget {
  var selectedpage = 2.obs;
  final _pageNo = [
    SizedBox(),
    SizedBox(),
    HomeScreen(),
    SizedBox(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() =>
          ConvexAppBar(
              activeColor: Colors.amber,
              backgroundColor: Colors.white,
              color: Colors.black,
              elevation: 3,
              items: [
                TabItem(icon: Icons.home),
                TabItem(icon: Icons.search),
                TabItem(icon: Icons.add_box_rounded),
                TabItem(icon: Icons.favorite_border),
                TabItem(icon: Icons.person),
              ],
              initialActiveIndex: selectedpage.value,
              onTap: (int index) {
                selectedpage(index);
              })),
      body: Obx(() =>
          Container(
            child: _pageNo[selectedpage.value],
          )),
    );
  }
}


