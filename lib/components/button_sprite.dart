import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class ButtonSprite extends PositionComponent with TapCallbacks {
  final SpriteComponent background;
  final String? title;
  final Function() onPressed;
  ButtonSprite(
      {required this.background,
      required this.onPressed,
      super.position,
      this.title}) {
    height = background.size.y;
    width = background.size.x;
    anchor = Anchor.center;
  }
  @override
  Future<void> onLoad() async {
    add(background);
    if (title != null) {
      add(TextComponent(
          textRenderer: TextPaint(
              style: const TextStyle(
                  fontSize: 18, color: Colors.white, height: 1)),
          text: title,
          anchor: Anchor.center,
          position: size / 2));
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    addAll([
      ScaleEffect.to(
        Vector2(0.8, 1.05),
        EffectController(duration: 0.07),
      ),
      ScaleEffect.to(
        Vector2(1.05, 0.95),
        EffectController(duration: 0.07, startDelay: 0.14),
      ),
      ScaleEffect.to(
        Vector2(0.95, 1.05),
        EffectController(duration: 0.07, startDelay: 0.21),
      ),
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(duration: 0.07, startDelay: 0.28),
      ),
    ]);
    onPressed.call();
  }
}
