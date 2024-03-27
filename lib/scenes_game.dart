import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_performance/components/type_of_exercise/fill_text_your_answers.dart';
import 'package:flame_performance/task_info_bar.dart';
import 'package:flutter/material.dart';

import 'components/menu_select_bar.dart';
import 'components/type_of_exercise/choose_your_answers.dart';
import 'components/type_of_exercise/sort_your_answers.dart';

class GameCtrl extends FlameGame {
  @override
  bool debugMode = false;

  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
    final myWorld = MyWorld();
    world = myWorld;
    camera = CameraComponent.withFixedResolution(
        width: 1280, height: 720, world: myWorld);
    camera.viewfinder.anchor = Anchor.topLeft;
    return super.onLoad();
  }
}

class MyWorld extends World with HasGameRef<GameCtrl> {
  Component? currentTab;
  late final List<Component> lst;
  MyWorld() {
    lst = [
      SortYourAnswers(size: Vector2(1000, 575), position: Vector2(26, 100)),
      ChooseYourAnswer(size: Vector2(1000, 575), position: Vector2(26, 100)),
      FillTextYourAnswer(size: Vector2(1000, 575), position: Vector2(26, 100)),
    ];
  }
  void onChange(int indexed) {
    if (currentTab != null) {
      remove(currentTab!);
    }
    currentTab = lst[indexed % 3];
    add(currentTab!);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(SpriteComponent(
        sprite: Sprite(game.images.fromCache("bg_main.png")),
        size: Vector2(1280, 720)));
    // add(TaskInfoBar(
    //     size: Vector2(180, 200), position: Vector2(1280 - 200, 10)));

    add(MenuSelectBar(
        size: Vector2(1000, 50),
        onTouch: onChange,
        position: Vector2(528, 12)));
    onChange(0);
    add(FpsTextComponent(position: Vector2(300, 300)));
  }
}
