import 'package:chatapp/abstract_widget/button_abstract.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class IOSButton implements PlatformButton {
  @override
  Widget build(BuildContext context, VoidCallback onPressed, String text) {
    return CupertinoButton.filled(onPressed: onPressed, child: Text(text));
  }
}
