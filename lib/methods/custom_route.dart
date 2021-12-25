import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_info/platform_info.dart';

PageRoute customRoute(Widget screen) {
  return Platform.instance.isCupertino
      ? CupertinoPageRoute(builder: (context) => screen)
      : MaterialPageRoute(builder: (context) => screen);
}
