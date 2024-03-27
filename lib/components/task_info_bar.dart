import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../count_down_timer.dart';


class TaskInfoBar extends RectangleComponent {
  TaskInfoBar({super.size, super.position}) {
    paint = Paint()..color = const Color(0xFFc8bbb7);
  }

  @override
  Future<void> onLoad() async {
    add(TimerGame(size: Vector2(148, 50), position: Vector2(width / 2, 10)));
    add(TextComponent(
        text: "tuyndev",
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(style: const TextStyle(fontSize: 18, height: 1, fontWeight: FontWeight.bold, color: Colors.white)),
        position: Vector2(width /2,76)));
    add(TextComponent(
        text: "ID: 3232695893",
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(style: const TextStyle(fontSize: 16, height: 1, fontWeight: FontWeight.bold, color: Colors.white)),
        position: Vector2(width /2,102)));
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTRB(0, 0, width, height);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    canvas.clipRRect(rrect);
    super.render(canvas);
  }
}

class TimerGame extends RectangleComponent
    with HasGameReference{
  TimerGame({super.size, super.position}) {
    anchor = Anchor.topCenter;
    paint = Paint()..color = const Color(0xFFa27c7c);
  }
  @override
  Future<void> onLoad() async {
    add(SpriteComponent(
        sprite: Sprite(game.images.fromCache("timer_icon.png")),
        size: Vector2.all(36),
        anchor: Anchor.centerLeft,
        position: Vector2(10, height / 2)));
    add(CountdownTimer(
        onFinish: () {
          print("Time's up");
        },
        limit: 90,
        anchor: Anchor.centerLeft,
        position: Vector2(56, (height / 2) + 4)));
    return super.onLoad();
  }

}
