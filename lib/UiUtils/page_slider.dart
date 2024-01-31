part of 'BottomTabView.dart';

@pragma('vm:entry-point')
void someFunction(int arg) {
  print("success1");
}

@pragma('vm:entry-point')
void someOtherFunction(int arg) {
  print("success2");
}
class PageSlider extends StatefulWidget {
  const PageSlider({super.key, required this.children});

  final List<Widget> children;

  @override
  State<PageSlider> createState() => _PageSliderState();
}

class _PageSliderState extends State<PageSlider> {
  var currentIndex = 0;
  PageController controller =
      PageController(initialPage: 0, viewportFraction: 1.0, keepPage: true);

  @override
  void initState() {
    // callIsolate();
    super.initState();
  }

  @override
  void dispose() {
    // FlutterIsolate.killAll();
    super.dispose();
  }

  callIsolate() async {
    var res = await FlutterIsolate.spawn(someFunction, 10);
    res.kill();
    var res2 = await FlutterIsolate.spawn(someOtherFunction, 20);
    res2.kill();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Stack(
          alignment: Alignment.centerRight,
          fit: StackFit.passthrough,
          children: [
            PageView(
              scrollDirection: Axis.vertical,
              controller: controller,
              pageSnapping: true,
              scrollBehavior: const ScrollBehavior(),
              onPageChanged: (value) => setState(() => currentIndex = value),
              children: widget.children
              /*.map((e) => controller.position.hasContentDimensions ?AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) => Transform.rotate(
                          origin: Offset.fromDirection(0.0),
                          angle:(controller.page??0 - widget.children.indexOf(e))*-25.15 ,
                          child: e,
                        ),
                      ) : CircularProgressIndicator())
                  .toList()*/
              ,
            ),
            Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.end,
                children: widget.children
                    .map((e) =>
                        Dot(currentIndex == widget.children.indexOf(e), () {
                          setState(
                              () => currentIndex = widget.children.indexOf(e));
                          controller.animateToPage(currentIndex,
                              duration: Duration(seconds: 2),
                              curve: Curves.linearToEaseOut);
                        }))
                    .toList())
          ]),
    );
  }

  Widget Dot(bool color, void Function()? onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 12,
          width: 12,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color ? Colors.red : Colors.blueGrey,
              border: Border.all(
                  color: Colors.grey,
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside)),
        ),
      );
}
