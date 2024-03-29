import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatapp/Animations/AnimationClass.dart';

class StatusScreen extends StatelessWidget {
  String imageUrl;
  var counter = 0.obs;

  StatusScreen({super.key, required this.imageUrl}) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Get.back(),
        onHorizontalDragUpdate: (details) => Get.back(),
        child: Container(
            height: Get.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blueGrey, Colors.orange, Colors.blueGrey]),
            ),
            child: Stack(
              children: [
                Column(children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.transparent,
                      )),
                  Expanded(
                    flex: 4,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) {
                        Timer.periodic(const Duration(milliseconds: 250), (Timer t) {
                          counter++;
                          if (counter.value > 100) {
                            t.cancel();
                            Get.back();
                          }
                        });
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                          ),
                        );
                      },
                      placeholder: (context, url) => const SpinningAnimation(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  /*Expanded(
                      flex: 4,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                        loadingBuilder:
                            (context, child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Colors.black,
                            ));
                          }
                        },
                      )),*/
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.transparent,
                      )),
                ]),
                Positioned(
                    left: 0,
                    top: 0,
                    child: Obx(() => Container(
                        color: Colors.red,
                        height: Get.height * (counter.value.toDouble() / 100),
                        width: 10))),
                Positioned(
                    left: 10,
                    top: 0,
                    child: Obx(() => Container(
                        color: Colors.red,
                        constraints: BoxConstraints(
                            minHeight: 0,
                            maxHeight: 10,
                            minWidth: 0,
                            maxWidth: Get.width *
                                (counter.value.toDouble() / 100))))),
                Positioned(
                    bottom: 10,
                    right: 0,
                    child: Obx(() => Container(
                        color: Colors.red,
                        height: Get.height * (counter.value.toDouble() / 100),
                        width: 10))),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Obx(() => Container(
                        color: Colors.red,
                        constraints: BoxConstraints(
                            minHeight: 0,
                            maxHeight: 10,
                            minWidth: 0,
                            maxWidth: Get.width *
                                (counter.value.toDouble() / 100))))),
              ],
            )),
      ),
    );
  }
}
