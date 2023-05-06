import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilsController extends GetxController {
  late var firebaseInstance;
  late SharedPreferences prefs;

  UtilsController() {
    init();
  }

  init() async {
    try {
      firebaseInstance = await Firebase.initializeApp();
    } catch (ee) {}
  }

  setLoggedin(bool val) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool("LoggedIn", val);
  }

  Future<bool> getLoggedin() async {
    prefs = await SharedPreferences.getInstance();
    return await prefs.getBool("LoggedIn") ?? false;
  }
}
