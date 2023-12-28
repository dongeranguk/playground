import 'package:playground/screen/main/tab/board/vo/vo_board_comment_list.dart';

class BoardComment {
  final int boardId;
  final int commentId;
  String content;

  BoardComment({
    required this.boardId,
    required this.commentId,
    required this.content,
  });

  List<BoardComment> boardCommentsByBoardId(int boardId) {
    return boardCommentList
        .where((element) => element.boardId == boardId)
        .toList();
  }
}
