import 'dart:async';

import 'package:flame/components.dart' hide Timer;
import 'package:flame_performance/scenes_game.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends PositionComponent with HasGameRef<GameCtrl> {
  late int _limit;
  void Function() onFinish;
  late TextComponent timerText;
  Vector2 offset = Vector2.zero();

  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      height: 1,
      color: Colors.white,
    ),
  );

  CountdownTimer(
      {required this.onFinish,
      super.anchor,
      required int limit,
      super.position}) {
    _limit = limit;
    size = Vector2(100, 28);
  }

  @override
  Future<void> onLoad() async {
    return super.onLoad();
  }

  @override
  void onMount() {
    if (_limit != null && _limit > 0) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_limit == 1) {
          _limit = 0;
          onFinish();
          timer.cancel();
        } else {
          _limit--;
        }
      });
    }
    super.onMount();
  }

  @override
  void render(Canvas canvas) {
    textPaint.render(canvas, _limit.toString(), offset);
    super.render(canvas);
  }
}
