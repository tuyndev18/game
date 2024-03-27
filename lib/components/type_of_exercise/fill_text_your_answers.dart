import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FillTextYourAnswer extends RectangleComponent{
  FillTextYourAnswer({super.size, super.position}) {
    paint = Paint()..color = Colors.red;
  }
}
