import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FillTextYourAnswer extends PositionComponent{
  FillTextYourAnswer({super.size, super.position}) {
    add(TextComponent(text: "fill text your", position: Vector2.all(100)));
  }
}
