part of 'AnimationClass.dart';

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