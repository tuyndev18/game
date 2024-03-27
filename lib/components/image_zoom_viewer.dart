import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_performance/utils/ui_ultis.dart';
import 'package:flutter/material.dart';


class ImageZoomViewer extends PositionComponent {
  final double height;
  final Sprite sprite;
  ImageZoomViewer(
      {required this.height, required this.sprite, super.position}) {
    anchor = Anchor.topCenter;
    final ratioSprite = sprite.aspectRatio;
    size = Vector2(height * ratioSprite, height);
  }
  @override
  Future<void> onLoad() async {
    add(SpriteComponent(sprite: sprite, size: size));
    add(ZoomIcon(position: Vector2(width - 22, height - 22)));
    return super.onLoad();
  }
}

class ZoomIcon extends RectangleComponent
    with HasGameReference, TapCallbacks {
  late Sprite _sprite;
  ZoomIcon({super.position}) {
    anchor = Anchor.center;
    paint = Paint()..color = Colors.black54;
  }
  @override
  Future<void> onLoad() async {
    _sprite = Sprite(game.images.fromCache("icon_kinhlup.png"));
    final ratioSprite = _sprite.aspectRatio;

    size = Vector2(32, 32 / ratioSprite);
    add(SpriteComponent(
        sprite: _sprite,
        position: Vector2.all(4),
        size: Vector2(width - 8, height - 8)));
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    addAll([
      ScaleEffect.to(
        Vector2.all(1.1),
        EffectController(duration: 0.08),
      ),
      ScaleEffect.to(
        Vector2.all(0.9),
        EffectController(duration: 0.08, startDelay: 0.08),
      ),
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(duration: 0.08, startDelay: 0.16),
      ),
    ]);
    super.onTapDown(event);
  }
}

class PreviewImageModal extends ValueRoute<dynamic>
    with TapCallbacks, HasGameReference{
  final Sprite image;

  PreviewImageModal({required this.image})
      : super(value: null, transparent: true);

  @override
  Component build() {
    return PreviewImageBuilder();
  }
}

class PreviewImageBuilder extends RectangleComponent with HasGameReference {
  PreviewImageBuilder();
  @override
  Future<void> onLoad() async {
    size = game.size;
    paint = Paint()..color = Colors.black45;
    return super.onLoad();
  }
}
