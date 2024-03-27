import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'button_sprite.dart';

enum ModalSpriteActionType { confirm, cancel }

class ModalSprite extends ValueRoute<ModalSpriteActionType>
    with TapCallbacks, HasGameReference {
  final Component content;
  final SpriteComponent background;
  final String cancelText;
  final SpriteComponent cancelSprite;
  String? okText;
  SpriteComponent? okSprite;

  ModalSprite({
    required this.content,
    required this.background,
    required this.cancelSprite,
    required this.cancelText,
    this.okSprite,
    this.okText,
  }) : super(value: ModalSpriteActionType.cancel, transparent: true);

  @override
  Component build() => ModalBuilder(
      background: background,
      content: content,
      cancelSprite: cancelSprite,
      completeWith: completeWith,
      cancelText: cancelText,
      okSprite: okSprite,
      okText: okText);
}

class ModalBuilder extends RectangleComponent
    with HasGameReference, TapCallbacks {
  final Component content;

  String? okText;
  final String cancelText;

  SpriteComponent? okSprite;
  final SpriteComponent cancelSprite;
  final SpriteComponent background;

  final Function(ModalSpriteActionType value) completeWith;

  ModalBuilder({
    required this.content,
    required this.background,
    required this.cancelSprite,
    required this.cancelText,
    required this.completeWith,
    this.okSprite,
    this.okText,
  });
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = game.size;
    paint = Paint()..color = Colors.black45;
    final container = RectangleComponent(
        size: background.size,
        paint: Paint()..color = Colors.transparent,
        anchor: Anchor.center,
        scale: Vector2.all(0),
        position: game.size / 2);
    container.addAll([
      background,
      ModalAction(
        okText: okText,
        okSprite: okSprite,
        cancelText: cancelText,
        cancelSprite: cancelSprite,
        completeWith: completeWith,
        size: Vector2(background.width, cancelSprite.height),
        position: Vector2(0, background.height - cancelSprite.height - 20),
      ),
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(duration: 0.2, curve: Curves.easeInOut),
      ),
    ]);
    add(container);
  }
}

class ModalAction extends RectangleComponent with HasGameReference {
  String? okText;
  final String cancelText;

  SpriteComponent? okSprite;
  final SpriteComponent cancelSprite;

  final Function(ModalSpriteActionType value) completeWith;

  ModalAction(
      {super.size,
      required this.cancelSprite,
      required this.cancelText,
      required this.completeWith,
      this.okText,
      this.okSprite,
      super.position});
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint = Paint()..color = Colors.transparent;
    double gapY = 15,
        offsetX = (width -
                cancelSprite.width -
                (okSprite == null ? 0 : (okSprite!.width + gapY))) /
            2;
    add(ButtonSprite(
        title: cancelText,
        position: Vector2(offsetX, 0),
        background: cancelSprite,
        onPressed: () => completeWith(ModalSpriteActionType.cancel)));
    offsetX += cancelSprite.width + gapY;
    if (okSprite != null) {
      add(ButtonSprite(
          title: okText,
          position: Vector2(offsetX, 0),
          background: okSprite!,
          onPressed: () => completeWith(ModalSpriteActionType.confirm)));
    }
  }
}
