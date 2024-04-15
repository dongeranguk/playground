import 'package:isar/isar.dart';

part 'vo_board.g.dart';

@collection
class Board {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String? title;

  @Index(type: IndexType.value)
  String content;
  int? likeCount;
  bool isRead;
  bool? isDeleted;
  final String createdBy;
  final DateTime createdAt;
  DateTime? updatedAt;
  List<BoardComment>? comments;


  Board(this.title, this.content,
      {required this.createdBy,
      this.likeCount = 0,
      this.isDeleted = false,
      this.comments,
      })
      : createdAt = DateTime.now(),
        updatedAt = null,
        isRead = false
  ;

  @override
  String toString() {
    return 'Board{id: $id, title: $title, content: $content, likeCount: $likeCount, isRead: $isRead, isDeleted: $isDeleted, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, comments: $comments}';
  }
}

@embedded
class BoardComment {
  BoardComment({this.content, this.createdBy}) : createdAt =  DateTime.now();
  String? content;
  String? createdBy;
  DateTime? createdAt;

  @override
  String toString() {
    return 'BoardComment{content: $content, createdBy: $createdBy, createdAt: $createdAt}';
  }


}
