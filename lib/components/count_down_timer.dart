import 'dart:async';

import 'package:flame/components.dart' hide Timer;
import 'package:flame_performance/utils/ui_ultis.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends PositionComponent with HasGameReference {
  late int _limit;
  void Function() onFinish;
  late TextComponent timerText;

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
    await super.onLoad();
    timerText =
        TextComponent(text: _limit.formattedTime, position: Vector2.zero());
    add(timerText);
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
        timerText.text = _limit.formattedTime;
      });
    }
  }
}
