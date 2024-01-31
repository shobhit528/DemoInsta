import 'dart:async';
import 'dart:isolate';

import 'package:chatapp/Get_IT.dart';
import 'package:chatapp/Login/LoginController.dart';
import 'package:chatapp/UtilsController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Animations/productView.dart';
import 'HomeScreen/HomeController.dart';
import 'Login/LoginScreen.dart';
import 'OTP/OTPController.dart';
import 'UiUtils/BottomTabView.dart';

Future<int> calculateFibonacci(int n) async {
  // Perform a time-consuming computation here.
  return await Future.delayed(const Duration(seconds: 2), () {
    int result = 0;
    int a = 0, b = 1;
    for (int i = 0; i < n; i++) {
      int temp = a;
      a = b;
      b = temp + b;
    }
    print("on thread ${Isolate.current.debugName} $b");
    return b;
  });
}

@pragma('vm:entry-point')
void isolateFunction(SendPort sendPort) {
  // Do some work in the isolate
  int result = 0;
  for (int i = 0; i < 1000000000; i++) {
    result += i;
  }
  Timer.periodic(const Duration(seconds: 1), (timer) {
    print("Timer Running From Isolate at tick ${timer.tick}");
    if (timer.tick == 10) {
      timer.cancel();
      print("on thread ${Isolate.current.debugName}");
      sendPort.send(result);
    }
  });

  // Send the result back to the main thread
}

Future<void> main2() async {
  comupteAndSpwans();
  ReceivePort receivePort = ReceivePort();

  Isolate.spawn(isolateFunction, receivePort.sendPort);
  receivePort.listen((message) {
    print("on thread ${Isolate.current.debugName}");
    print("Isolate result: $message");
  });
}

comupteAndSpwans() async {
  // Isolate.spawn(computeFibonacci, 30);
  final result = await compute(calculateFibonacci, 30);
  print('Fibonacci(30) = $result');
  return result;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationController.initializeLocalNotifications();

  try {
    GetItClass().setup();
  } catch (e) {}

  getIt<UtilsController>().getLoggedin().then((value) {
    runApp(
      // MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider.value(value: DemoProvider()),
      //     ChangeNotifierProvider.value(value: DemoProvider1()),
      //     ChangeNotifierProvider.value(value: DemoProvider2()),
      //     ChangeNotifierProvider.value(value: DemoProvider3()),
      //   ],
      //   child: MyApp(value),
      // ),
      MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            lazy: false,
            create: (BuildContext context) => LoginBloc(context: context),
          ),
          BlocProvider<CarouselCubit>(
            lazy: false,
            create: (BuildContext context) => CarouselCubit(),
          ),
          BlocProvider<OTPBloc>(
            lazy: true,
            create: (BuildContext context) => OTPBloc(context: context),
          ),
          BlocProvider<HomeBloc>(
            lazy: false,
            create: (BuildContext context) => HomeBloc(context: context),
          ),
        ],
        child: MyApp(value),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  bool isLoggedIn;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  MyApp(this.isLoggedIn, {Key? key}) : super(key: key) {
    // NotificationController.startListeningNotificationEvents();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'InstaBuzz',
      key: navigatorKey,
      darkTheme: ThemeData(
        primarySwatch: Colors.red,
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.system,
      home: isLoggedIn ? BottomTabView() : const LoginScreen(),
      // home: OptionalClass(),
      // home: MyGeoLocation(title: "MYGeo"),
    );
  }
}

enum Gender {male, female,others}

class OptionalClass extends StatelessWidget {
  OptionalClass({super.key});

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final ValueNotifier<String> _city = ValueNotifier<String>("Others");
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> cityList = [
    "Delhi",
    "Mumbai",
    "Chennai",
    "Kolkata",
    "Others"
  ];

  OutlineInputBorder border() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.blueGrey, width: 0.5));

  Widget textField(BuildContext context, String hintText) => Padding(
        padding: EdgeInsets.all(getResponsiveFontSize(context, size: 2)),
        child: TextFormField(
          maxLines: 1,
          key: Key(hintText.trim()),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          style: TextStyle(fontSize: getResponsiveFontSize(context, size: 10)),
          decoration: InputDecoration(
              hintText: hintText,
              errorStyle:
                  TextStyle(fontSize: getResponsiveFontSize(context, size: 7)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.blueGrey, width: 0.5))),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: getResponsiveFontSize(context, size: 10)),
        child: ListView(shrinkWrap: true, children: [
          Center(
              child: Text(
            _controller.text.isEmpty
                ? "Show Alert Dialog"
                : _controller.text.toString(),
            style: TextStyle(fontSize: getResponsiveFontSize(context)),
          )),
          Form(
            key: _formKey,
            child: Column(children: [
              textField(context, "Enter first name here"),
              textField(context, "Enter last name here"),
              textField(context, "Enter email here"),
              textField(context, "Enter number here"),
              ValueListenableBuilder<int>(
                builder: (BuildContext context, int v, Widget? child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getResponsiveFontSize(context, size: 2)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:Gender.values.map<Widget>((e) => Expanded(
                            flex: 2,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => _counter.value = e.index,
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Transform.scale(
                                        scale: getResponsiveFontSize(context,
                                            size: 1.0),
                                        child: Radio(
                                          value: e.index,
                                          groupValue: v,
                                          onChanged: (int? value) {
                                            _counter.value = value!;
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: getResponsiveFontSize(context,size: 2)),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        e.name,
                                        style: TextStyle(
                                            fontSize: getResponsiveFontSize(
                                                context,
                                                size: 10)),
                                      ),
                                    )
                                  ]),
                            ))).toList()
                        // children: [
                        //   Expanded(
                        //       flex: 2,
                        //       child: GestureDetector(
                        //         behavior: HitTestBehavior.translucent,
                        //         onTap: () => _counter.value = 0,
                        //         child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceAround,
                        //             children: [
                        //               Expanded(
                        //                 flex: 1,
                        //                 child: Transform.scale(
                        //                   scale: getResponsiveFontSize(context,
                        //                       size: 1.0),
                        //                   child: Radio(
                        //                     value: 0,
                        //                     groupValue: v,
                        //                     onChanged: (int? value) {
                        //                       _counter.value = value!;
                        //                     },
                        //                   ),
                        //                 ),
                        //               ),
                        //               Expanded(
                        //                 flex: 3,
                        //                 child: Text(
                        //                   "Male",
                        //                   style: TextStyle(
                        //                       fontSize: getResponsiveFontSize(
                        //                           context,
                        //                           size: 10)),
                        //                 ),
                        //               )
                        //             ]),
                        //       )),
                        //   Expanded(
                        //       flex: 2,
                        //       child: GestureDetector(
                        //         behavior: HitTestBehavior.translucent,
                        //         onTap: () => _counter.value = 1,
                        //         child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceAround,
                        //             children: [
                        //               Expanded(
                        //                 flex: 1,
                        //                 child: Transform.scale(
                        //                   scale: getResponsiveFontSize(context,
                        //                       size: 1.0),
                        //                   child: Radio(
                        //                     value: 1,
                        //                     groupValue: v,
                        //                     onChanged: (int? value) {
                        //                       _counter.value = value!;
                        //                     },
                        //                   ),
                        //                 ),
                        //               ),
                        //               Expanded(
                        //                 flex: 3,
                        //                 child: Text(
                        //                   "Female",
                        //                   style: TextStyle(
                        //                       fontSize: getResponsiveFontSize(
                        //                           context,
                        //                           size: 10)),
                        //                 ),
                        //               )
                        //             ]),
                        //       )),
                        // ],
                  ),
                  );
                },
                valueListenable: _counter,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getResponsiveFontSize(context, size: 2)),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: border(),
                    ),
                    focusColor: Colors.transparent,
                    isExpanded: true,
                    items: cityList
                        .map((String e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(
                                    fontSize: getResponsiveFontSize(context,
                                        size: 10)),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) => _city.value = value.toString(),
                    value: _city.value),
              ),
              SizedBox(height: getResponsiveFontSize(context, size: 5)),

              Visibility(
                visible: false,
                child: AspectRatio(aspectRatio:  22 ,child: FilledButton(
                onPressed: () {
                  _formKey.currentState?.validate();
                },
                child: Padding(
                    padding: EdgeInsets.all(
                        getResponsiveFontSize(context, size: 5)),
                    child: Text("Submit form",
                        style: TextStyle(
                            fontSize: getResponsiveFontSize(context,
                                size: 10)))))),
              ),
              SizedBox(
                  child: FilledButton(
                      onPressed: () {
                        _formKey.currentState?.validate();
                      },
                      child: Padding(
                          padding: EdgeInsets.all(
                              getResponsiveFontSize(context, size: 5)),
                          child: Text("Submit form",
                              style: TextStyle(
                                  fontSize: getResponsiveFontSize(context,
                                      size: 10))))))
            ]),
          )
        ]),
      ),
    );
  }
}

double getResponsiveFontSize(BuildContext context, {double size = 10}) {
  return MediaQuery.of(context).size.longestSide* 0.0018 * size;
}

class DemoProvider extends ChangeNotifier {
  String DemoAppName = "asdasd";
}

class DemoProvider1 extends ChangeNotifier {
  String DemoAppName1 = "asdasd";
}

class DemoProvider2 extends ChangeNotifier {
  String DemoAppName2 = "asdasd";
}

class DemoProvider3 extends ChangeNotifier {
  String DemoAppName3 = "asdasd";
}


