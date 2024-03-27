import 'package:flame/components.dart';
import 'package:flutter/material.dart';

extension GetContext on BuildContext {
  // get Height of Scaffold
  double get getHeight => MediaQuery.of(this).size.height;

  // get Width of Scaffold
  double get getWidth => MediaQuery.of(this).size.width;

  // get Padding of SafeArea
  EdgeInsets get getPadding => MediaQuery.of(this).padding;
}

extension Utils on int {
  String get formattedTime {
    int sec = this % 60;
    int min = (this / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }
}

extension UtilsSprite on Sprite {
  double get aspectRatio {
    return image.width / image.height;
  }
}
