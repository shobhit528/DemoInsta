import 'package:chatapp/abstract_widget/abstract_factory.dart';
import 'package:chatapp/abstract_widget/android_button.dart';
import 'package:flutter/cupertino.dart';

import 'ios_button.dart';

abstract class PlatformButton {
  Widget build(BuildContext context,VoidCallback onPressed, String text);

  factory PlatformButton(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return AndroidButton();
      case TargetPlatform.iOS:
        return IOSButton();
      default:
        return AndroidButton();
    }
  }
}
