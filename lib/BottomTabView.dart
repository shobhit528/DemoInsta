import 'package:chatapp/Animations/AnimationClass.dart';
import 'package:chatapp/HomeScreen/HomeScreen.dart';
import 'package:chatapp/ProfileScreen/ProfileScreen.dart';
import 'package:chatapp/UI_Utils.dart';
import 'package:chatapp/UtilsController.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ProductList/product_list.dart';
import 'Shaders/Shader_Class.dart';

class BottomTabView extends StatelessWidget {
  var selectedpage = 0.obs;
  final _pageNo = [
    // FlyingAnimation(),
    // const SpinningAnimation(),
    // GyroClass(),
    // ExampleAnimation(),
    // PlayOneShotAnimation(),
    // ShaderHomePage(),
    CircularAnimation(),
    ProductScreen(),
    OrientationBuilder(
        builder: (context, orientation) => Container(
              color: Colors.black,
              height: Get.height,
              width: Get.width,
              child: UiUtils().rainWidget(childWidget: SizedBox()),
            )),
    HomeScreen(),
    OrientationBuilder(
        builder: (context, orientation) => Container(
              color: Colors.black,
              height: Get.height,
              width: Get.width,
              child: UiUtils().birdWidget(childWidget: SizedBox()),
            )),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() => ConvexAppBar(
          curveSize: 60.mobileFont(),
          curve: Curves.bounceInOut,
          activeColor: Colors.amber,
          backgroundColor: Colors.white,
          color: Colors.black,
          elevation: 3,
          items: const [
            TabItem(icon: Icons.animation),
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
      body: Obx(() => Container(
            child: _pageNo[selectedpage.value],
          )),
    );
  }
}
