import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../entity/entity.dart';

final alphabets =
    List.generate(26, (index) => String.fromCharCode(index + 65)).toList();

final colors = [
  const Color(0xFFff4600),
  const Color(0xFFffc800),
  const Color(0xFF00a0ff),
  const Color(0xFF00b478)
];

class ChooseTheCorrectAnswer extends PositionComponent with TapCallbacks {
  double gap = 20, heightAnswer = 65;
  int colSpan = 2, countAnswer = 4;
  List<AnswerEntity> answers;

  ChooseTheCorrectAnswer(
      {super.size, required this.answers, super.anchor, super.position}) {
    height = heightAnswer * 2 + gap;
  }

  @override
  Future<void> onLoad() async {
    double widthAnswer = (width - ((colSpan - 1) * gap)) / colSpan,
        offsetX = widthAnswer / 2,
        offsetY = heightAnswer / 2;

    for (int index = 0; index < countAnswer; index++) {
      add(SelectAnswer(
          index: index,
          answer: answers[index],
          size: Vector2(widthAnswer, heightAnswer),
          position: Vector2(offsetX, offsetY)));
      double wrapX = offsetX + widthAnswer + gap;
      offsetX = wrapX > width ? (widthAnswer / 2) : wrapX;
      offsetY = wrapX > width ? (offsetY + heightAnswer + gap) : offsetY;
    }

    return super.onLoad();
  }
}

class SelectAnswer extends PositionComponent with TapCallbacks {
  double radius = 12;
  final int index;
  final AnswerEntity answer;
  final AudioPlayer player = AudioPlayer();
  SelectAnswer(
      {required super.size,
      required this.answer,
      required this.index,
      required super.position}) {
    anchor = Anchor.center;
  }

  @override
  void onTapDown(TapDownEvent event) async {
    addAll([
      ScaleEffect.to(
        Vector2.all(0.95),
        EffectController(duration: 0.1),
      ),
      ScaleEffect.to(
        Vector2.all(1.05),
        EffectController(duration: 0.1, startDelay: 0.1),
      ),
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(duration: 0.1, startDelay: 0.2),
      ),
    ]);
    await player.play();
    super.onTapDown(event);
  }

  @override
  Future<void> onLoad() async {
    addAll([
      RectangleComponent.square(
          size: height, paint: Paint()..color = colors[index]),
      RectangleComponent(
          paint: Paint()..color = Colors.white,
          size: Vector2(width - height, height),
          position: Vector2(height, 0)),
      TextComponent(
          text: alphabets[index],
          position: Vector2(height / 2, height / 2),
          anchor: Anchor.center),
      MyAnswerContents(answer.content, maxWidth: (width - height))
        ..position = Vector2(((width - height) / 2) + height + 20, height / 2),
    ]);
    await player.setUrl(
        "https://cdn.ioe.vn/edu/EOlympic/ExamData/Thi_cac_cap/2020-2021/Lop3/Captruong/Audio/3-dt-37.mp3");
    player.playerStateStream.listen((event) async {
      if (event.processingState == ProcessingState.completed) {
        await player.pause();
        await player.seek(Duration.zero);
      }
      print(event);
    });
    return super.onLoad();
  }

}

class MyAnswerContents extends TextBoxComponent {
  MyAnswerContents(
    String text, {
    super.align,
    super.size,
    required double maxWidth,
  }) : super(
          text: text,
          anchor: Anchor.center,
          textRenderer: TextPaint(style: const TextStyle(fontSize: 18)),
          boxConfig: TextBoxConfig(
            maxWidth: maxWidth,
          ),
        );
}
