import 'package:chatapp/ChatScreen/ChatController.dart';
import 'package:get_it/get_it.dart';
import 'package:chatapp/HomeScreen/HomeController.dart';
import 'package:chatapp/Login/LoginController.dart';
import 'package:chatapp/OTP/OTPController.dart';
import 'package:chatapp/UtilsController.dart';

final getIt = GetIt.instance;

class GetItClass {

  void setup() {
    getIt.registerSingleton<UtilsController>(UtilsController());
    getIt.registerSingleton<HomeController>(HomeController());
    getIt.registerSingleton<LoginController>(LoginController());
    getIt.registerSingleton<OTPController>(OTPController());
    getIt.registerSingleton<ChatController>(ChatController());
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
