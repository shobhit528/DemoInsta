import 'package:chatapp/abstract_widget/button_abstract.dart';
import 'package:chatapp/abstract_widget/indicator_abstract.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AbstractFactory{
  Widget buildButton(BuildContext context,String text,VoidCallback onPressed);
  Widget buildIndicator(BuildContext context);
}


class AbstractFactoryImpl extends AbstractFactory{
  @override
  Widget buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return PlatformButton(Theme.of(context).platform).build(context, onPressed, text);
  }

  @override
  Widget buildIndicator(BuildContext context) {
    return PlatformIndicator(Theme.of(context).platform).build();
  }

}