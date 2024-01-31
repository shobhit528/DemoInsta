import 'package:chatapp/Animations/AnimationClass.dart';
import 'package:chatapp/HomeScreen/HomeScreen.dart';
import 'package:chatapp/ProfileScreen/ProfileScreen.dart';
import 'package:chatapp/UI_Utils.dart';
import 'package:chatapp/UtilsController.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:get/get.dart';

import '../ListblocPage/list_bloc_page.dart';
import '../ProductList/product_list.dart';
import '../Shaders/Shader_Class.dart';
import '../abstract_widget/new_page.dart';


part 'page_slider.dart';

class BottomTabView extends StatelessWidget {
  var selectedpage = 0.obs;
  final _pageNo = [
    // const SpinningAnimation(),
    // PlayOneShotAnimation(),
    PageSlider(children: [
      BlocListPage(),
      NewPage(),
      DragAnimation(),
      CircularAnimation(),
      FlyingAnimation(),
      GyroClass(),
      const SpinningAnimation(),
      ShaderHomePage(),
    ]),
    ProductScreen(),
    OrientationBuilder(
        builder: (context, orientation) => Container(
              color: Colors.black,
              height: Get.height,
              width: Get.width,
              child: UiUtils().rainWidget(childWidget: const SizedBox()),
            )),
    HomeScreen(),
    OrientationBuilder(
        builder: (context, orientation) => Container(
              color: Colors.black,
              height: Get.height,
              width: Get.width,
              child: UiUtils().birdWidget(childWidget: const SizedBox()),
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