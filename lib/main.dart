import 'package:chatapp/BottomTabView.dart';
import 'package:chatapp/Get_IT.dart';
import 'package:chatapp/Login/LoginController.dart';
import 'package:chatapp/Login/LoginScreen.dart';
import 'package:chatapp/UtilsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Animations/productView.dart';
import 'HomeScreen/HomeController.dart';
import 'OTP/OTPController.dart';
import 'UiUtils/notification_controller.dart';

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

  MyApp(this.isLoggedIn, {Key? key}) : super(key: key){
    // NotificationController.startListeningNotificationEvents();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'InstaBuzz',
      key: navigatorKey,
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
