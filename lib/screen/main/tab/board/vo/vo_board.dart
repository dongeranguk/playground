import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_comment.dart';

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
      this.comments})
      : createdAt = DateTime.now(),
        updatedAt = null,
        isRead = false;

  // void setComments(List<BoardComment> comments) {
  //   for (BoardComment comment in comments) {
  //     if (comment.boardId == id) {
  //       this.comments?.add(comment);
  //     }
  //   }
  // }


  @override
  String toString() {
    return 'Board{id: $id, title: $title, content: $content, likeCount: $likeCount, isRead: $isRead, isDeleted: $isDeleted, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, comments: $comments}';
  }

  List<BoardComment>? get boardComments => comments;
}

@embedded
class BoardComment {
  String? content;
}
