import 'dart:math';

import 'package:chatapp/UtilsController.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neon/neon.dart';

import '../UiUtils/notification_controller.dart';

class ListAnimation extends StatefulWidget {
  ListAnimation({super.key});

  @override
  State<StatefulWidget> createState() => ListStateNew();
}

class ListStateNew extends State<ListAnimation>
    with SingleTickerProviderStateMixin {
  PageController pageController = PageController(viewportFraction: 0.8);

  var dataList = [
    {"name": "Sam Reimi", "image": "".randomImage(200, 200)},
    {"name": "Read Richards", "image": "".randomImage(200, 200)},
    {"name": "Bruce Banner", "image": "".randomImage(200, 200)},
  ];
  AnimationController? _controller;
  Animation<double>? _animation;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 100,
      ),
      vsync: this,
      value: 0.1,
    );
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.bounceIn,
    );
    setState(() {});
    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    pageController.dispose();
    super.dispose();
  }

  Widget ExamplePage(Color color, String s, int number) {
    return AnimatedContainer(
      height: currentPage == number ? Get.height / 1.5 : Get.height / 2,
      width: Get.width / 2,
      color: color,
      margin: EdgeInsets.all(20),
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 900),
      transform: Matrix4.translationValues(10, 20, 30),
      child: Stack(
        children: [
          Center(
            child: Text(s),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: AnimatedBuilder(
              animation: pageController,
              builder: (_, __) {
                final double page = pageController.page ?? 0;
                final double rotation =
                    (page - number) * -1.0; // Adjust the rotation speed here

                return Transform.rotate(
                  angle: rotation,
                  child: Hero(
                    tag: "food${number}",
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/food.png'),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ExpandablePageView.builder(
        animateFirstPage: true,
        itemCount: dataList.length,
        alignment: Alignment.center,
        controller: pageController,
        animationCurve: Curves.linearToEaseOut,
        animationDuration: const Duration(seconds: 1),
        onPageChanged: (value) => setState(() => currentPage = value),
        itemBuilder: (context, index) => scalePage(index),
      ),
    ));
  }

  Widget scalePage(int index) {
    return AnimatedBuilder(
        animation: pageController,
        builder: (context, child) => Transform.scale(
              origin: Offset.fromDirection(0.0, 10.0),
              alignment: Alignment.centerLeft,
              scale: max(
                0.2,
                (1 - (pageController.page! - index).abs() / 2),
              ),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      // NotificationController.createNewNotification()
                    },
                    child: Container(
                      height: Get.height * 0.6,
                      width: Get.width,
                      padding: const EdgeInsets.all(5),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          gradient: const RadialGradient(
                              colors: [Colors.red, Colors.brown, Colors.blueGrey],
                              stops: [0.02, 0.4, 0.6],
                              radius: 1,
                              focalRadius: 5),
                          border:
                              Border.all(color: Colors.grey.shade400, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Transform.scale(
                                scale: _animation?.value,
                                child: Neon(
                                  text: dataList[index]["name"]!,
                                  color: Colors.green,
                                  fontSize: 30,
                                  font:NeonFont.Monoton,
                                  flickeringText: true,
                                  flickeringLetters: [0],
                                )),
                            AnimatedBuilder(
                              animation: pageController,
                              builder: (_, __) {
                                final double page = pageController.page ?? 0;
                                final double rotation = (page - index) *
                                    -1.0; // Adjust the rotation speed here
                                print(rotation);
                                return Transform.rotate(
                                  angle: rotation,
                                  child: Hero(
                                    tag: "food${index}",
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              dataList[index]["image"]!),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                          ]),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: AnimatedBuilder(
                      animation: pageController,
                      builder: (_, __) {
                        final double page = pageController.page ?? 0;
                        final double rotation = (page - index) *
                            -1.0; // Adjust the rotation speed here
                        if (kDebugMode) {
                          print(rotation);
                        }
                        return Transform.rotate(
                          angle: rotation,
                          child: Hero(
                            tag: "food${index}",
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient:  LinearGradient(colors: [
                                  Colors.white10,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.white10
                                ], stops: [
                                  0.1,
                                  0.3,
                                  0.4,
                                  0.5,
                                  0.6,
                                  0.9
                                ]),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white10, width: 10),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: AnimatedBuilder(
                      animation: pageController,
                      builder: (_, __) {
                        final double page = pageController.page ?? 0;
                        final double rotation = (page - index) *
                            -5.0; // Adjust the rotation speed here
                        if (kDebugMode) {
                          print(rotation);
                        }
                        return Transform.rotate(
                          angle: rotation,
                          child: Hero(
                            tag: "food${index}",
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient:  LinearGradient(colors: [
                                  Colors.white10,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.teal.shade200,
                                  Colors.transparent,
                                  Colors.white10
                                ], stops: [
                                  0.1,
                                  0.3,
                                  0.4,
                                  0.5,
                                  0.6,
                                  0.9
                                ]),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white10, width: 10),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ));
  }
}
