import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

import '../../entity/entity.dart';
import '../choose_the_correct_answer.dart';
import '../image_zoom_viewer.dart';

class ChooseYourAnswer extends RectangleComponent with HasGameReference {
  ChooseYourAnswer({super.size, super.position}) {
    paint = Paint()..color = Colors.transparent;
  }
  @override
  void onLoad() async {
    await super.onLoad();
    add(ChooseTheCorrectAnswer(
        answers: [
          AnswerEntity(
              dataType: 0,
              content: "How",
              type: CONTENT_TYPE.LONG_TEXT,
              contentId: 1,
              Id: 0,
              orderTrue: 0,
              subjectId: 0),
          AnswerEntity(
              dataType: 0,
              content: "Who",
              type: CONTENT_TYPE.LONG_TEXT,
              contentId: 1,
              Id: 0,
              orderTrue: 0,
              subjectId: 0),
          AnswerEntity(
              dataType: 0,
              content: "How old",
              type: CONTENT_TYPE.LONG_TEXT,
              contentId: 1,
              Id: 0,
              orderTrue: 0,
              subjectId: 0),
          AnswerEntity(
              dataType: 0,
              content: "What",
              type: CONTENT_TYPE.LONG_TEXT,
              contentId: 1,
              Id: 0,
              orderTrue: 0,
              subjectId: 0)
        ],
        anchor: Anchor.topCenter,
        size: Vector2(width * 0.95, 0),
        position: Vector2(width / 2, height - 160)));

    add(ImageZoomViewer(
        height: 150,
        position: Vector2(width / 2, 20),
        sprite: Sprite(game.images.fromCache("bg_progress.png"))));
    add(MyTextBox(
        size: Vector2(width * 0.9, 200), position: Vector2(width / 2, 190)));
  }
}

class MyTextBox extends RectangleComponent {
  MyTextBox({super.size, super.position}) {
    anchor = Anchor.topCenter;
    paint = Paint()..color = Colors.black26;
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(MyTextBoxContainer(
        position: Vector2(0, 0),
        text:
            "MV Chúng ta của tương lai được Sơn Tùng M-TP phát hành vào đúng 0h hôm nay (8/3) và MV này đã nhanh chóng giành vị trí số 1"
            "của Trending Music Youtube Việt Nam. Cho đến thời điểm này, sau hơn 14 giờ phát hành, MV đã có hơn 4,8 triệu lượt người xem, MV Chúng ta của tương lai được Sơn Tùng M-TP phát hành vào đúng 0h hôm nay (8/3) và MV này đã nhanh chóng giành vị trí số 1"
            "của Trending Music Youtube Việt Nam. Cho đến thời điểm này, sau hơn 14 giờ phát hành, MV đã có hơn 4,8 triệu lượt người xem, MV Chúng ta của tương lai được Sơn Tùng M-TP phát hành vào đúng 0h hôm nay (8/3) và MV này đã nhanh chóng giành vị trí số 1"
            "của Trending Music Youtube Việt Nam. Cho đến thời điểm này, sau hơn 14 giờ phát hành, MV đã có hơn 4,8 triệu lượt người xem, MV Chúng ta của tương lai được Sơn Tùng M-TP phát hành vào đúng 0h hôm nay (8/3) và MV này đã nhanh chóng giành vị trí số 1"
            "của Trending Music Youtube Việt Nam. Cho đến thời điểm này, sau hơn 14 giờ phát hành, MV đã có hơn 4,8 triệu lượt người xem,"
            ".",
        size: Vector2(width, 500),
        boxConfig: TextBoxConfig(
          growingBox: true,
          margins: const EdgeInsets.all(16),
        )));
  }
}

class MyTextBoxContainer extends TextBoxComponent {
  @override
  final double fontSize = 16, heightText = 1.5;

  late TextStyle style;

  MyTextBoxContainer(
      {super.text, super.boxConfig, super.size, super.position}) {
    style =
        TextStyle(fontSize: fontSize, height: heightText, color: Colors.white);
    final span = TextSpan(text: text, style: style);
    final textPainter =
        TextPainter(text: span, textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: width);
    final numLines = textPainter.computeLineMetrics().length;
    height = numLines * fontSize * lineHeight + boxConfig.margins.top * 2;
  }
}
