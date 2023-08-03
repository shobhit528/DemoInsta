part of 'AnimationClass.dart';

class FlyingAnimation extends StatefulWidget {
  Color? bgColor, circleColor;

  FlyingAnimation({super.key, this.bgColor = Colors.black54, this.circleColor});

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

  Widget _buildAnimation({bool blend = false}) {
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
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.circleColor ?? Colors.transparent),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              "assets/images/bird_bg.gif",
              fit: BoxFit.fill,
              colorBlendMode: BlendMode.srcATop,
              color: blend ? Colors.black : Colors.transparent,
            ),
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
          child: _buildAnimation(blend: true),
        ),
        Container(
          height: Get.height,
          width: Get.width,
          color: widget.circleColor == null ? Colors.black54 : widget.bgColor,
          child: Center(child: _buildAnimation()),
        ),
      ],
    );
  }
}
