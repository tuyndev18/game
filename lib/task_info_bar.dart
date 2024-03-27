import 'package:flame/components.dart';
import 'package:flame_performance/scenes_game.dart';
import 'package:flutter/material.dart';

import 'count_down_timer.dart';


class TaskInfoBar extends RectangleComponent {
  late final Rect rect;
  late final RRect rrect;

  TaskInfoBar({super.size, super.position}) {
    paint = Paint()..color = const Color(0xFFc8bbb7);
    rect = Rect.fromLTRB(0, 0, width, height);
    rrect = RRect.fromRectAndRadius(rect, const Radius.circular(10));
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(TimerGame(size: Vector2(148, 50), position: Vector2(width / 2, 10)));
    add(TextComponent(
        text:"tuyndev",
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
            style: const TextStyle(
                fontSize: 18,
                height: 1,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        position: Vector2(width / 2, 76)));
    add(TextComponent(
        text: "ID: ${0}",
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
            style: const TextStyle(
                fontSize: 16,
                height: 1,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        position: Vector2(width / 2, 106)));
    add(RectangleComponent(
        size: Vector2(width * 0.8, 2),
        position: Vector2(width / 2, 132),
        anchor: Anchor.topCenter));
  }
}

class TimerGame extends RectangleComponent
    with HasGameRef<GameCtrl>, HasWorldReference<MyWorld> {
  final Paint _borderPaint = Paint()
    ..strokeWidth = 4
    ..style = PaintingStyle.stroke
    ..color = Colors.white;
  late final Rect rect;
  late final RRect rrect;

  TimerGame({super.size, super.position}) {
    anchor = Anchor.topCenter;
    rect = Rect.fromLTRB(0, 0, width, height);
    paint = Paint()..color = const Color(0xFFa27c7c);
    rrect = RRect.fromRectAndRadius(rect, const Radius.circular(6));
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(SpriteComponent(
        sprite: Sprite(game.images.fromCache("timer_icon.png")),
        size: Vector2.all(36),
        anchor: Anchor.centerLeft,
        position: Vector2(10, height / 2)));
    add(CountdownTimer(
        onFinish: () {

        },
        limit:1200,
        anchor: Anchor.centerLeft,
        position: Vector2(56, (height / 2) + 4)));
  }

}
