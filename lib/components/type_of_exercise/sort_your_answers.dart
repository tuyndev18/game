import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../button_sprite.dart';
import '../modal_sprite.dart';
import '../select_card_box_sorting.dart';

class SortYourAnswers extends RectangleComponent with HasGameReference {
  late final SelectCardBoxSorting selectCardBoxSorting;
  SortYourAnswers({super.size, super.position}) {
    paint = Paint()..color = Colors.transparent;
  }

  void onSendAnswers() async {}

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    selectCardBoxSorting = SelectCardBoxSorting<Map<String, String>>(
        ratioCard: 150 / 200,
        anchor: Anchor.center,
        size: Vector2(width * 0.8, 0),
        dataSource: [
          {"content": "not"},
          {"content": "That is"},
          {"content": "Peter's pen"},
          {"content": "but it's"},
        ],
        position: Vector2(width / 2, (height - 40) / 2),
        backgroundCard: Sprite(game.images.fromCache("select_card.png")),
        backgroundIdleCard:
            Sprite(game.images.fromCache("idle_select_card.png")),
        renderContents: (details) => details["content"] ?? "");
    add(selectCardBoxSorting);
    add(ButtonSprite(
        title: "ANSWER",
        position: Vector2(width - 105, height - 50),
        background: SpriteComponent(
            sprite: Sprite(game.images.fromCache("bg_button.png")),
            size: Vector2(120, 45)),
        onPressed: onSendAnswers));
  }
}
