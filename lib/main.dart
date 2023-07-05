import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:tsttech/BottomTabView.dart';
import 'package:tsttech/Get_IT.dart';
import 'package:tsttech/Login/LoginScreen.dart';
import 'package:tsttech/UtilsController.dart';

import 'Geofencing.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    GetItClass().setup();
  } catch (e) {}

  getIt<UtilsController>().getLoggedin().then((value) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider.value(value: DemoProvider()),
      ChangeNotifierProvider.value(value: DemoProvider1()),
      ChangeNotifierProvider.value(value: DemoProvider2()),
      ChangeNotifierProvider.value(value: DemoProvider3()),
    ], child: MyApp(value)));
  });
}

class MyApp extends StatelessWidget {
  bool isLoggedIn;

  MyApp(this.isLoggedIn, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? BottomTabView() : LoginScreen(),
      // home:  BottomTabView(),
      // home: MyGeoLocation(title: "MYGeo"),
    );
  }
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

