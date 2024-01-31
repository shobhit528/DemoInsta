import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_abstract.dart';

class AndroidButton implements PlatformButton{
  @override
  Widget build(BuildContext context, VoidCallback onPressed, String text) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }

}