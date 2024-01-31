part of 'AnimationClass.dart';

@pragma('vm:entry-point')
void isolate2(String arg) async{
  Timer.periodic(Duration(seconds: 1), (timer) {
    print("Timer Running From Isolate 2");
  });
}

@pragma('vm:entry-point')
void receiverIsolateFunction(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort); // Send the ReceivePort to the sender isolate

  receivePort.listen((message) {
    print('Received message in receiver isolate: $message');
    // Handle the received data here.
  });
}


@pragma('vm:entry-point')
void isolate1(String arg) async {
  Timer.periodic(
      Duration(seconds: 1), (timer) {
    print("Timer Running From Isolate 1");
  });
}
@pragma('vm:entry-point')
void isolateFunction(SendPort sendPort) {
  // Do some work in the isolate
  int result = 0;
  for (int i = 0; i < 1000000000; i++) {
    result += i;
  }
  Timer.periodic(
      const Duration(seconds: 1), (timer) {
    print("Timer Running From Isolate at tick ${timer.tick}");
    if(timer.tick==10){
      timer.cancel();
      sendPort.send(result);
    }
  });

  // Send the result back to the main thread

}

class DragAnimation extends StatefulWidget {
  @override
  State<DragAnimation> createState() => _DragAnimationState();
}

class _DragAnimationState extends State<DragAnimation>
    with TickerProviderStateMixin {
  double x_negative = 0.0;
  double x_positive = 0.0;
  Tween? tween = Tween<double>(begin: 0.0, end: 360.0);

  @override
  void initState() {
    super.initState();
    /*  isolate();
    callIsoLates();
    ISOLATE();*/

  }
  isolate(){
    ReceivePort receivePort = ReceivePort();
    Isolate.spawn(isolateFunction, receivePort.sendPort);
    receivePort.listen((message) {
      print("Isolate result: $message");
    });


    ReceivePort receivePort2 = ReceivePort();
    Isolate.spawn(isolateFunction, receivePort2.sendPort);
    receivePort2.listen((message) {
      if (kDebugMode) {
        print("Isolate 2 result: $message");
      }
      FlutterIsolate.runningIsolates.then((value) => print(value));
    });
  }

  ISOLATE() async{
    final receivePort = ReceivePort();
    await Isolate.spawn(receiverIsolateFunction, receivePort.sendPort);

    final sendPort = await receivePort.first; // Get the SendPort from the receiver isolate

    sendPort.send('Hello from sender isolate!');
  }


  @override
  void dispose() {
    FlutterIsolate.killAll();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    FlutterIsolate.killAll();
  }

  callIsoLates() async {
      final isolate = await FlutterIsolate.spawn(isolate1, "hello");
      final isolate_2 = await FlutterIsolate.spawn(isolate2, "hello2");
      Timer(const Duration(seconds: 5), () {print("Pausing Isolate 1");isolate.pause();print("Pausing Isolate 2");isolate_2.pause();});
      Timer(const Duration(seconds: 10), () {print("Resuming Isolate 1");isolate.resume();print("Resuming Isolate 2");isolate_2.resume();});
      Timer(const Duration(seconds: 20), () {
        print("Killing Isolate 2");
        isolate_2.kill();
        print("Killing Isolate 1");
        isolate.kill();

      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanUpdate: (details) {
          x_positive += details.delta.dx * 0.01;

          setState(() {
            x_positive %= pi * 2;
          });
        },
        child: Container(
          height: Get.height,
          width: Get.width,
          alignment: Alignment.center,
          child: TweenAnimationBuilder(
              duration: Duration(seconds: 2),
              tween: tween!,
              builder: (context, value, child) =>
                  Stack(fit: StackFit.loose, children: [
                    Transform.rotate(
                      angle: x_positive,
                      child: SizedBox(
                        width: 100.mobileFont(),
                        child: Row(children: [
                          Container(
                              height: 15.mobileFont(),
                              width: 15.mobileFont(),
                              decoration: const BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle)),
                          Container(
                              height: 15.mobileFont(),
                              width: 15.mobileFont(),
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle))
                        ]),
                      ),
                    ),
                    Transform.rotate(
                      angle: x_positive + 0.1.mobileFont(),
                      child: SizedBox(
                        width: 100.mobileFont(),
                        child: Row(children: [
                          Container(
                              height: 15.mobileFont(),
                              width: 15.mobileFont(),
                              decoration: const BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle)),
                          Container(
                              height: 15.mobileFont(),
                              width: 15.mobileFont(),
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle))
                        ]),
                      ),
                    ),
                    Transform.rotate(
                      angle: x_positive + 0.3.mobileFont(),
                      child: SizedBox(
                        width: 100.mobileFont(),
                        child: Row(children: [
                          Container(
                              height: 15.mobileFont(),
                              width: 15.mobileFont(),
                              decoration: const BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle)),
                          Container(
                              height: 15.mobileFont(),
                              width: 15.mobileFont(),
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle))
                        ]),
                      ),
                    ),
                    Transform.rotate(
                      angle: x_positive + 0.5.mobileFont(),
                      child: SizedBox(
                        width: 100.mobileFont(),
                        child: Row(children: [
                          Container(
                              height: 15.mobileFont(),
                              width: 15.mobileFont(),
                              decoration: const BoxDecoration(
                                  color: Colors.blueGrey,
                                  shape: BoxShape.circle)),
                          Container(
                              height: 15.mobileFont(),
                              width: 15.mobileFont(),
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle))
                        ]),
                      ),
                    ),
                    Transform.rotate(
                      angle: x_positive + 0.7.mobileFont(),
                      child: SizedBox(
                        width: 100.mobileFont(),
                        child: Row(children: [
                          Container(
                              height: 15.mobileFont(),
                              width: 15.mobileFont(),
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle)),
                          Container(
                              height: 15.mobileFont(),
                              width: 15.mobileFont(),
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle))
                        ]),
                      ),
                    )
                  ])),
        ),
      ),
    );
  }
}
