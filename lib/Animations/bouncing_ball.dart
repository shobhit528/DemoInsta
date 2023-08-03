part of 'AnimationClass.dart';

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