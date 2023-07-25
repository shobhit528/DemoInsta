import 'dart:ui';

import 'package:chatapp/UI_Utils.dart';
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

  String get getRandomImage => "?random&t=${DateTime.now()}";

  String get getRandomBlurImage => "$getRandomImage?blur=2";
}

extension FancyNum on String {
  String randomImage(a, b) =>
      "https://picsum.photos/${a}/$b${UtilsController().getRandomImage}";

  String randomImageWithOutDimention({int hightScale=1,int widthScale=1}) =>
      "https://picsum.photos/${widthScale*512}/${hightScale*512}${UtilsController().getRandomImage}";

  String randomBlurImageWithOutDimention({int hightScale=1,int widthScale=1}) =>
      "https://picsum.photos/${widthScale*512}/${hightScale*512}${UtilsController().getRandomBlurImage}";

  String random() => this + UtilsController().getRandomImage;

  String randomBlur() => this + UtilsController().getRandomBlurImage;
}

extension RationalNum on double {
  double mobileFont() => UiUtils().isMobile() ? this : this * 1.5;
}

extension IntegerNum on int {
  double mobileFont() => UiUtils().isMobile() ? this * 1.0 : this * 1.5;
}

Color AppThemeColor = const Color.fromRGBO(249, 179, 109, 1);