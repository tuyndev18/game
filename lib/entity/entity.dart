enum CONTENT_TYPE {
  TEXT,
  IMAGE,
  AUDIO,
  VIDEO,
  LONG_TEXT,
  SPLIT_TEXT,
  TRUE_OR_FALSE,
}

class ContentEntity {
  int dataType;
  String content;
  CONTENT_TYPE type;
  int contentId;
  int Id;
  int subjectId;
  int orderTrue;

  ContentEntity(
      {required this.dataType,
      required this.content,
      required this.type,
      required this.contentId,
      required this.Id,
      required this.orderTrue,
      required this.subjectId});
}

class AnswerEntity extends ContentEntity {
  AnswerEntity(
      {required super.dataType,
      required super.content,
      required super.type,
      required super.contentId,
      required super.Id,
      required super.orderTrue,
      required super.subjectId});
}
