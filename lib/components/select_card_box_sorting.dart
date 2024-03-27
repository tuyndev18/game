import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart' hide Route;

class SelectCardBoxSorting<T> extends RectangleComponent
    with HasGameReference {
  Sprite backgroundCard;
  final double ratioCard;
  final List<T> dataSource;
  Sprite backgroundIdleCard;
  final String Function(T detailsCard) renderContents;
  double gapX = 20, gapY = 20, spaceBoxCards = 30;
  double _widthCard = 0, _heightCard = 0, _heightBoxCards = 0;

  final int _columnsNumber = 5;
  List<int?> _arrIndexed = [];

  // get attributes value
  set columnsNumber(int number) {
    columnsNumber = _columnsNumber;
  }

  // get attributes value
  List<int?> get arrIndexed => _arrIndexed;
  List<T> get answersSorted =>
      _arrIndexed.map((index) => dataSource[index!]).toList();

  SelectCardBoxSorting({
    super.anchor,
    super.position,
    super.size,
    required this.ratioCard,
    required this.dataSource,
    required this.backgroundCard,
    required this.renderContents,
    required this.backgroundIdleCard,
  }) {
    paint = Paint()..color = Colors.transparent;

    this._widthCard = (width - ((_columnsNumber - 1) * gapX)) / _columnsNumber;
    this._heightCard = _widthCard * (1 / ratioCard);
    this._arrIndexed = List.generate(dataSource.length, (_) => null);

    int countRows = (dataSource.length / _columnsNumber).ceil();
    _heightBoxCards = ((countRows * _heightCard) + ((countRows - 1) * gapY));

    height = spaceBoxCards + (_heightBoxCards * 2);
  }

  @override
  Future<void> onLoad() async {
    for (int index = 0; index < dataSource.length; index++) {
      final boxCardPosition = _getBoxCardPosition(index: index);
      final cardBox = CardBox(
          width: _widthCard,
          index: index,
          details: dataSource[index],
          background: backgroundIdleCard,
          content: null,
          height: _heightCard - 10,
          position: boxCardPosition,
          onTapSelectedBoxCard: _onTapSelectedBoxCard);
      add(cardBox);
    }
    for (int index = 0; index < dataSource.length; index++) {
      final boxCardPosition = _getBoxCardPosition(
          index: index, startY: _heightBoxCards + spaceBoxCards);
      final cardBox = CardBox(
          width: _widthCard,
          index: index,
          details: dataSource[index],
          background: backgroundCard,
          content: renderContents(dataSource[index]),
          height: _heightCard,
          position: boxCardPosition,
          onTapSelectedBoxCard: _onTapSelectedBoxCard);
      add(cardBox);
    }
    return super.onLoad();
  }

  Vector2 _getBoxCardPosition({required int index, double startY = 0}) {
    int position = (index / _columnsNumber).floor();
    int rowColumnNumber = ((position + 1) * _columnsNumber) <= dataSource.length
        ? _columnsNumber
        : dataSource.length % _columnsNumber;
    double startX = (width -
            ((_widthCard * rowColumnNumber) + (gapX * (rowColumnNumber - 1)))) /
        2;
    double offsetX = startX +
        ((_widthCard + gapX) * (index % _columnsNumber)) +
        _widthCard / 2;
    double offsetY =
        _heightCard / 2 + ((_heightCard + gapY) * position) + startY;
    return Vector2(offsetX, offsetY);
  }

  void _onTapSelectedBoxCard(int index) {
    final moveIndex = _arrIndexed.indexOf(null);
    final arrSelectCarBox = children.skip(dataSource.length).toList();
    final selectedIndex = _arrIndexed.indexWhere((indexed) => indexed == index);

    List<Effect> effects = [
      // ScaleEffect.to(
      //   Vector2.all(0.9),
      //   EffectController(duration: 0.1),
      // ),
      // ScaleEffect.to(
      //   Vector2.all(1.1),
      //   EffectController(duration: 0.1, startDelay: 0.1),
      // ),
      // ScaleEffect.to(
      //   Vector2.all(1),
      //   EffectController(duration: 0.1, startDelay: 0.2),
      // ),
    ];

    if (selectedIndex == -1) {
      _arrIndexed[moveIndex] = index;
      final movingPosition = _getBoxCardPosition(index: moveIndex);
      arrSelectCarBox[index].addAll([
        ...effects,
        MoveToEffect(
          movingPosition,
          EffectController(
              duration: 0, curve: Curves.linear),
        ),
      ]);
    } else {
      _arrIndexed[selectedIndex] = null;
      final movingPosition = _getBoxCardPosition(
          index: index, startY: _heightBoxCards + spaceBoxCards);
      arrSelectCarBox[index].addAll([
        ...effects,
        MoveToEffect(
            movingPosition,
            EffectController(
                duration: 0, curve: Curves.linear))
      ]);
    }
  }
}

class CardBox<T> extends PositionComponent with TapCallbacks {
  final int index;
  final T details;
  final Sprite background;
  final String? content;
  final Function(int index) onTapSelectedBoxCard;
  CardBox({
    super.position,
    required this.index,
    this.content,
    required double width,
    required this.background,
    required this.details,
    required double height,
    required this.onTapSelectedBoxCard,
  }) {
    this.width = width;
    this.height = height;
  }
  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    add(SpriteComponent(sprite: background, size: Vector2(width, height)));
    add(TextComponent(
        text: content,
        textRenderer: TextPaint(
            style: const TextStyle(
                fontSize: 18,
                color: Colors.brown,
                fontWeight: FontWeight.w600)),
        anchor: Anchor.center,
        position: Vector2(width / 2, height / 2)));
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (content == null) return;
    onTapSelectedBoxCard(index);
    super.onTapDown(event);
  }
}
