part of 'AnimationClass.dart';

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