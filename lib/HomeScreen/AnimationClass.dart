import 'dart:async';

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
              .map((e) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 20,
                    constraints: BoxConstraints(
                        minHeight: 0, maxHeight: marginTop * e / 2),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(228, 200, 210 * e * 2, 1),
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

class SpinningAnimation extends StatefulWidget {
  const SpinningAnimation({super.key});

  @override
  State<StatefulWidget> createState() => AnimationStateOne();
}

class AnimationStateOne extends State<SpinningAnimation>
    with TickerProviderStateMixin {
  Animation<double>? _angleAnimation, _angleAnimation2;

  Animation<double>? _scaleAnimation;

  AnimationController? _controller, _controller2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _controller2 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _controller2?.stop();
    _angleAnimation = Tween(begin: 0.0, end: 360.0).animate(_controller!)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    _angleAnimation2 = Tween(begin: 0.0, end: 360.0).animate(_controller2!)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    _scaleAnimation = Tween(begin: 1.0, end: 6.0).animate(_controller!)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });

    _angleAnimation?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller?.reverse();
        _controller2?.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller?.forward();
        _controller2?.forward();
      }
    });
    _controller?.forward();

    // _angleAnimation2?.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _controller?.reset();
    //   } else if (status == AnimationStatus.dismissed) {
    //     _controller2?.forward();
    //   }
    // });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller2?.dispose();
    super.dispose();
  }

  Widget _buildAnimation() {
    double circleWidth = 130.0;
    Widget circles = SizedBox(
      width: circleWidth * 2.0,
      height: circleWidth * 2.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildAnimationCircle(circleWidth, Colors.blue, scale: 1),
              _buildAnimationCircle(circleWidth, Colors.red, scale: 1),
            ],
          ),
          Row(
            children: <Widget>[
              _buildAnimationCircle(circleWidth, Colors.yellow,
                  scaleY: -1, scale: -1),
              _buildAnimationCircle(circleWidth, Colors.green, scaleY: -1),
            ],
          ),
        ],
      ),
    );

    double angleInDegrees = _angleAnimation!.value;
    return Transform.rotate(
      angle: angleInDegrees / 360 * 2 * 22 / 7,
      child: Container(
        child: circles,
      ),
    );
  }

  Widget _buildAnimationCircle(double circleWidth, Color color,
      {double scale = -1, double scaleY = 1}) {
    Widget circles = _buildImageCircle(circleWidth, Colors.blue,
        scale: scale, scaleY: scaleY);
    double angleInDegrees = _angleAnimation2!.value;
    return Transform.rotate(
      angle: angleInDegrees / 360 * 2 * 22 / 7,
      child: Container(
        child: circles,
      ),
    );
  }

  Widget _buildImageCircle(double circleWidth, Color color,
      {double scale = -1, double scaleY = 1}) {
    return Transform.scale(
      scaleX: scale,
      scaleY: scaleY,
      child: Transform.rotate(
        angle: _controller2!.value,
        child: Container(
          width: circleWidth,
          height: circleWidth,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.asset("assets/images/loadimg.png", fit: BoxFit.fill),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 150),
          child: _buildAnimation(),
        ),
        Container(
          height: Get.height,
          width: Get.width,
          color: Colors.black54,
          child: Center(child: _buildAnimation()),
        ),
      ],
    );
  }
}

class FlyingAnimation extends StatefulWidget {
  const FlyingAnimation({super.key});

  @override
  State<StatefulWidget> createState() => FlyingAnimationOne();
}

class FlyingAnimationOne extends State<FlyingAnimation>
    with TickerProviderStateMixin {
  Animation<double>? _angleAnimation;

  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _angleAnimation = Tween(begin: 360.0, end: 0.0).animate(_controller!)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });

    _angleAnimation?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller?.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller?.forward();
      }
    });
    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildAnimation() {
    double circleWidth = 130.0;
    return Transform.rotate(
      // angle: _angleAnimation!.value / 360 * 2 * 22 / 7,
      angle: 0,
      child: Transform.rotate(
        angle: 0,
        child: SizedBox(
          width: circleWidth * 2.0,
          height: circleWidth * 2.0,
          child: Container(
            width: circleWidth,
            height: circleWidth,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset("assets/images/bird_bg.gif", fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 150),
          child: _buildAnimation(),
        ),
        Container(
          height: Get.height,
          width: Get.width,
          color: Colors.black54,
          child: Center(child: _buildAnimation()),
        ),
      ],
    );
  }
}
