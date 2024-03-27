import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';


enum MenuSelectItemsStatus { idle, selected, disable }

class MenuSelectBar extends RectangleComponent {
  late MenuSelectTrack menuSelectTrack;
  late MenuSelectContainer menuSelectContainer;
final Function(int indexed) onTouch;
  MenuSelectBar({super.size, required this.onTouch, super.position}) {
    anchor = Anchor.topCenter;
  }

  void onTouchSelectItem(int indexed) {
    onTouch.call(indexed);
    menuSelectContainer.currentSelectItems = indexed;
    menuSelectContainer.updateMenuSelectItems();
  }
  void onNextItems(int index) {
    menuSelectContainer.currentSelectItems = index;
    if((index % menuSelectTrack.colNumber) == (menuSelectTrack.colNumber - 1)) {
      menuSelectTrack.onNext();
    }
  }

  @override
  Future<void> onLoad() async {
    menuSelectTrack = MenuSelectTrack(
        onTouchSelectItem: onTouchSelectItem,
        countItems: 10,
        size: Vector2(890, height - 10),
        position: size / 2);
    add(menuSelectTrack);
    add(ButtonAction(
        onTouch: menuSelectTrack.onPrevious, position: Vector2(0, 0)));
    add(ButtonAction(
        onTouch: menuSelectTrack.onNext, position: Vector2(width - 50, 0)));
    menuSelectContainer = menuSelectTrack.menuSelectContainer;
    return super.onLoad();
  }
}

class MenuSelectTrack extends PositionComponent {
  final double _gapX = 10, colNumber = 10;
  int _page = 1;

  late double widthMenutItems;
  late double widthMenuSelectContainer;
  late MenuSelectContainer menuSelectContainer;

  final int countItems;
  final Function(int indexed) onTouchSelectItem;

  
  
  MenuSelectTrack(
      {super.size,
      super.position,
      required this.onTouchSelectItem,
      required this.countItems}) {
    anchor = Anchor.center;
    final spaceX = (colNumber - 1) * _gapX;
    widthMenutItems = (width - spaceX) / colNumber;
    widthMenuSelectContainer = (width * colNumber) + spaceX;
  }

  void onNext() {
    final countPage = (countItems / colNumber).ceil();
    if(_page == countPage) return;
    menuSelectContainer.add(MoveByEffect(Vector2(-(width + _gapX), 0),
        EffectController(duration: 0)));
    _page++;
  }

  void onPrevious() {
    if(_page == 1) return;
    menuSelectContainer.add(MoveByEffect(Vector2(width + _gapX, 0),
        EffectController(duration: 0, curve: Curves.fastLinearToSlowEaseIn)));
    _page--;
  }

  @override
  Future<void> onLoad() async {
    menuSelectContainer = MenuSelectContainer(
        gapX: _gapX,
        widthMenutItems: widthMenutItems,
        onTouchSelectItem: onTouchSelectItem,
        size: Vector2(widthMenuSelectContainer, height),
        countItems: countItems);
    add(menuSelectContainer);
    return super.onLoad();
  }
}

class MenuSelectContainer extends PositionComponent {
  final double gapX;
  final int countItems;
  final double widthMenutItems;
  final Function(int indexed) onTouchSelectItem;
  int currentSelectItems = 0;

  MenuSelectContainer(
      {super.size,
      required this.gapX,
      required this.countItems,
      required this.onTouchSelectItem,
      required this.widthMenutItems});
  @override
  Future<void> onLoad() async {
    for (int index = 0; index < countItems; index++) {
      final offsetX = ((widthMenutItems + gapX) * index) + widthMenutItems / 2;
      add(MenuSelectItems(
        index: index,
        onTouchSelectItem: onTouchSelectItem,
        position: Vector2(offsetX, height / 2),
        size: Vector2(widthMenutItems, height),
        status: index == currentSelectItems
            ? MenuSelectItemsStatus.selected
            : MenuSelectItemsStatus.idle,
      ));
    }
    return super.onLoad();
  }

  void updateMenuSelectItems() {
    final selectItems = children.query<MenuSelectItems>().toList();
    for (int index = 0; index < selectItems.length; index++) {
      selectItems[index].status = index == currentSelectItems
          ? MenuSelectItemsStatus.selected
          : MenuSelectItemsStatus.idle;
    }
  }
}

class MenuSelectItems extends PositionComponent
    with HasGameReference, TapCallbacks {
  final int index;
  late SpriteComponent _background;
  MenuSelectItemsStatus status;
  final Function(int indexed) onTouchSelectItem;

  MenuSelectItems(
      {super.size,
      required this.status,
      required this.onTouchSelectItem,
      super.position,
      required this.index}) {
    anchor = Anchor.center;
  }

  Sprite _getSpriteBackground() {
    switch (status) {
      case MenuSelectItemsStatus.idle:
      case MenuSelectItemsStatus.disable:
        return Sprite(game.images.fromCache("bg_button.png"));
      case MenuSelectItemsStatus.selected:
        return Sprite(game.images.fromCache("bg_button--red.png"));
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final sprite = _getSpriteBackground();
    _background = SpriteComponent(sprite: sprite, size: size);
    add(_background);
    add(TextComponent(
        textRenderer: TextPaint(
            style:
                const TextStyle(fontSize: 18, color: Colors.white, height: 1, fontWeight: FontWeight.bold)),
        text: "${index + 1}",
        anchor: Anchor.center,
        position: size / 2));
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (status == MenuSelectItemsStatus.disable) return;
    onTouchSelectItem(index);
  }

}

class ButtonAction extends RectangleComponent with TapCallbacks {
  final void Function() onTouch;
  ButtonAction({required this.onTouch, super.position}) {
    size = Vector2(50, 50);
    paint = Paint()..color = Colors.red;
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTouch();
    super.onTapDown(event);
  }
}
