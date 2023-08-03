import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';


part 'flying_animation.dart';
part 'flip_animation.dart';
part 'bouncing_line.dart';
part 'bouncing_ball.dart';
part 'spinning_animation.dart';
part 'gyronimation.dart';

class AnimationClass extends StatefulWidget {
  const AnimationClass({super.key});

  @override
  State<StatefulWidget> createState() => AnimationState();
}

class AnimationState extends State<AnimationClass>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController controller;

  @override
  void initState() {
    setState(() {
      controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      )..repeat(reverse: false);
      _animation = CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Center(
        child: RotationTransition(
          turns: _animation,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: const [
                BouncingBall(type: 1),
                // BouncingBall(type: 2),
                BouncingBall(type: 3),
                BouncingBall(type: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



