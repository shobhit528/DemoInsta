import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      )
        ..repeat(reverse: false);
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

class BouncingLine extends StatefulWidget {
  const BouncingLine({super.key});

  @override
  State<BouncingLine> createState() => _BouncingLineState();
}

class _BouncingLineState extends State<BouncingLine> {
  late String direction;
  late double marginTop;
  late double increment;
  late double start;
  late double end;
  late Duration duration;

  @override
  void initState() {
    super.initState();
    marginTop = 0;
    direction = 'down';
    increment = 1;
    start = 0;
    end = 100;
    duration = const Duration(microseconds: 9000);

    Timer.periodic(duration, bounce);
  }

  void setDirection() {
    if (marginTop == end) {
      setState(() {
        direction = 'up';
      });
    }

    if (marginTop == start) {
      setState(() {
        direction = 'down';
      });
    }
  }

  void bounce(Timer t) {
    setDirection();
    setState(() {
      if (direction == 'down') {
        marginTop += increment;
      } else {
        marginTop -= increment;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [2, 4, 2, 6, 2, 4, 2, 6, 2, 4, 2]
              .map((e) =>
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 20,
                constraints: BoxConstraints(
                    minHeight: 0, maxHeight: marginTop * e / 2),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(228, 200, 210 * e*2, 1),
                    borderRadius: BorderRadius.circular(e * 2.toDouble())),
              ))
              .toList()),
    );
  }
}

class BouncingBall extends StatefulWidget {
  final int type;

  const BouncingBall({super.key, required this.type});

  @override
  State<BouncingBall> createState() => _BouncingBallState();
}

class _BouncingBallState extends State<BouncingBall> {
  late String direction;
  late double marginTop;
  late double increment;
  late double start;
  late double end;
  late Duration duration;

  @override
  void initState() {
    super.initState();
    marginTop = 0;
    direction = 'down';
    increment = 25;
    start = 0;
    end = 100;
    duration = const Duration(milliseconds: 100);

    Timer.periodic(duration, bounce);
  }

  void setDirection() {
    if (marginTop == end) {
      setState(() {
        direction = 'up';
      });
    }

    if (marginTop == start) {
      setState(() {
        direction = 'down';
      });
    }
  }

  void bounce(Timer t) {
    setDirection();
    setState(() {
      if (direction == 'down') {
        marginTop += increment;
      } else {
        marginTop -= increment;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: getMargin(),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(color: getColor(), shape: BoxShape.circle),
      ),
    );
  }

  EdgeInsets getMargin() {
    switch (widget.type) {
      case 1:
        return EdgeInsets.only(right: marginTop);
      case 2:
        return EdgeInsets.only(bottom: marginTop);
      case 3:
        return EdgeInsets.only(right: marginTop);
      case 4:
        return EdgeInsets.only(bottom: marginTop);
      default:
        return EdgeInsets.only(top: marginTop);
    }
  }

  getColor() {
    switch (widget.type) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.green;
      case 3:
        return Colors.blueGrey;
      case 4:
        return Colors.deepOrange;
      default:
        return Colors.pink;
    }
  }
}
