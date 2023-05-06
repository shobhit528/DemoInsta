import 'package:get_it/get_it.dart';
import 'package:tsttech/HomeScreen/HomeController.dart';
import 'package:tsttech/Login/LoginController.dart';
import 'package:tsttech/OTP/OTPController.dart';
import 'package:tsttech/UtilsController.dart';

final getIt = GetIt.instance;

class GetItClass {

  void setup() {
    getIt.registerSingleton<UtilsController>(UtilsController());
    getIt.registerSingleton<HomeController>(HomeController());
    getIt.registerSingleton<LoginController>(LoginController());
    getIt.registerSingleton<OTPController>(OTPController());
    // GetIt.I.registerLazySingleton<RESTAPI>(() =>RestAPIImplementation());
  }
}

class DemoClass {
  static final DemoClass _demoClass = DemoClass._internal();

  factory DemoClass() {
    return _demoClass;
  }

  DemoClass._internal();
}
