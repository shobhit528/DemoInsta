part of 'AnimationClass.dart';

class FlipCard extends StatefulWidget {
  Widget? childWidget;

  FlipCard({super.key, required this.childWidget});

  @override
  State<StatefulWidget> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  int seconds = 900;
  late Timer? t1, t2;

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: seconds))
      ..forward();
    _animation = Tween(end: 1.0, begin: 0.0).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });

    // _animationController?.forward();
    _animationController?.addListener(() {
      if (_animationController?.status == AnimationStatus.completed) {
        _animationController?.reverse();
      }
      if (_animationController?.status == AnimationStatus.dismissed) {
        _animationController?.forward();
      }
    });
    super.initState();
  }

  fastAnimate() {
    _animationController?.duration = const Duration(milliseconds: 100);
  }

  decreaseAnimateSpeed() {
    t1 = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _animationController?.duration = Duration(milliseconds: timer.tick);
      if (timer.tick >= 900) {
        timer.cancel();
      }
    });
    setState(() {});
  }

  increaseAnimateSpeed() {
    var counter = 0;
    t1 =
        Timer.periodic(const Duration(milliseconds: 10), (timer) {
          setState(() {
            counter=timer.tick;
          });
          _animationController?.duration = Duration(milliseconds: counter);
          if(counter==seconds){
            timer.cancel();
          }
        });
  }

  nutraliseSpeed() {
    t2 = Timer(const Duration(seconds: 3), () {
      _animationController?.duration = Duration(milliseconds: seconds);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateY(pi * _animation?.value),
      child: GestureDetector(
          onTap: () {
            setState(() {
              t1 = null;
              t2 = null;
            });
            // fastAnimate();
            // decreaseAnimateSpeed();
            // nutraliseSpeed();

            increaseAnimateSpeed();
          },
          child: widget.childWidget),
    );
  }
}
