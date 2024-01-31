import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PlatformIndicator {
  Color color();

  Widget build();

  factory PlatformIndicator(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return AndroidIndicator();
      case TargetPlatform.iOS:
        return IOSIndicator();
      default:
        return AndroidIndicator();
    }
  }
}

class AndroidIndicator implements PlatformIndicator {
  @override
  Widget build() {
    return Center(child: CircularProgressIndicator(color: color()));
  }

  @override
  Color color() {
    return Colors.grey;
  }
}

class IOSIndicator implements PlatformIndicator {
  @override
  Widget build() {
    return Center(child: CupertinoActivityIndicator(color: color()));
  }

  @override
  Color color() {
    return Colors.pinkAccent;
  }
}
