part of 'AnimationClass.dart';

class CircularAnimation extends StatefulWidget {
  @override
  State<CircularAnimation> createState() => _CircularAnimationState();
}

class _CircularAnimationState extends State<CircularAnimation>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  late Animation<double> _scaleUpDown;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    Tween(begin: 0, end: 360).animate(animationController);
    super.initState();
    animationController.forward();
    animationController.addListener(() {
      setState(() {
        if (animationController.status == AnimationStatus.completed) {
          animationController.repeat();
        }
      });
    });

    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _fadeInFadeOut = Tween<double>(begin: 0.5, end: 1.0).animate(animation);
    _scaleUpDown = Tween<double>(begin: 0.3, end: 1.0).animate(animation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        alignment: Alignment.center,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Stack(children: [
            Transform.rotate(
              angle: animationController.value * pi * 35.mobileFont(),
              child: SizedBox(
                width: 100.mobileFont(),
                child: Row(children: [
                  FadeTransition(
                    opacity: animation,
                    child: Transform.scale(
                      scale: _scaleUpDown.value,
                      child: Container(
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle)),
                    ),
                  ),
                  Container(
                      height: 15.mobileFont(),
                      width: 15.mobileFont(),
                      decoration: const BoxDecoration(
                          color: Colors.transparent, shape: BoxShape.circle))
                ]),
              ),
            ),
            Transform.rotate(
              angle: animationController.value * pi * 40.mobileFont(),
              child: SizedBox(
                width: 100.mobileFont(),
                child: Row(children: [
                  FadeTransition(
                    opacity: animation,
                    child: Transform.scale(
                      scale: _scaleUpDown.value,
                      child: Container(
                          height: 15.mobileFont(),
                          width: 15.mobileFont(),
                          decoration: const BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle)),
                    ),
                  ),
                  Container(
                      height: 15.mobileFont(),
                      width: 15.mobileFont(),
                      decoration: const BoxDecoration(
                          color: Colors.transparent, shape: BoxShape.circle))
                ]),
              ),
            ),
            Transform.rotate(
              angle: animationController.value * pi * 45.mobileFont(),
              child: SizedBox(
                width: 100.mobileFont(),
                child: Row(children: [
                  FadeTransition(
                    opacity: animation,
                    child: Transform.scale(
                      scale: _scaleUpDown.value,
                      child: Container(
                          height: 15.mobileFont(),
                          width: 15.mobileFont(),
                          decoration: const BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle)),
                    ),
                  ),
                  Container(
                      height: 15.mobileFont(),
                      width: 15.mobileFont(),
                      decoration: const BoxDecoration(
                          color: Colors.transparent, shape: BoxShape.circle))
                ]),
              ),
            ),
            Transform.rotate(
              angle: animationController.value * pi * 50.mobileFont(),
              child: SizedBox(
                width: 100.mobileFont(),
                child: Row(children: [
                  FadeTransition(
                    opacity: animation,
                    child: Transform.scale(
                      scale: _scaleUpDown.value,
                      child: Container(
                          height: 15.mobileFont(),
                          width: 15.mobileFont(),
                          decoration: const BoxDecoration(
                              color: Colors.blueGrey, shape: BoxShape.circle)),
                    ),
                  ),
                  Container(
                      height: 15.mobileFont(),
                      width: 15.mobileFont(),
                      decoration: const BoxDecoration(
                          color: Colors.transparent, shape: BoxShape.circle))
                ]),
              ),
            ),
            Transform.rotate(
              angle: animationController.value * pi * 25.mobileFont(),
              child: SizedBox(
                width: 100.mobileFont(),
                child: Row(children: [
                  FadeTransition(
                    opacity: animation,
                    child: Transform.scale(
                      scale: _scaleUpDown.value,
                      child: Container(
                          height: 15.mobileFont(),
                          width: 15.mobileFont(),
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle)),
                    ),
                  ),
                  Container(
                      height: 15.mobileFont(),
                      width: 15.mobileFont(),
                      decoration: const BoxDecoration(
                          color: Colors.transparent, shape: BoxShape.circle))
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
