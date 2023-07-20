import 'package:chatapp/BottomTabView.dart';
import 'package:chatapp/Get_IT.dart';
import 'package:chatapp/Login/LoginController.dart';
import 'package:chatapp/Login/LoginScreen.dart';
import 'package:chatapp/UtilsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'OTP/OTPController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
              create: (BuildContext context) => LoginBloc(),
            ),
            BlocProvider<OTPBloc>(
              create: (BuildContext context) => OTPBloc(context: context),
            ),
          ],
          child: MyApp(value),
        )
    );
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
