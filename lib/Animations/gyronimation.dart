part of 'AnimationClass.dart';

class GyroClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GyroState();
}

class GyroState extends State<GyroClass> with SingleTickerProviderStateMixin {
  Stream<GyroscopeEvent>? stream;
  bool isGyroSensor = false;
  Offset? offset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.lightBlueAccent,
              Colors.blueGrey,
              Colors.grey,
              Colors.white
            ],
                stops: [
              0.25,
              0.6,
              0.7,
              0.8,
            ])),
        height: Get.height,
        width: Get.width,
        child: Center(
            child: StreamBuilder(
          stream: gyroscopeEvents,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else if (snapshot.hasData) {
              // print(snapshot.data);
              var data = snapshot.data as GyroscopeEvent;
              return AnimatedRotation(
                turns: data.y,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(seconds: 3),
                child: AnimatedSlide(
                  offset: Offset(0, data.x),
                  duration: Duration(seconds: 2),
                  child: ImageContainer(),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        )),
      ),
    );
  }

  Widget ImageContainer() => Container(
        width: 200,
        height: 200,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          "assets/images/bird_bg.gif",
          fit: BoxFit.fill,
        ),
      );
}
