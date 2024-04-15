import 'dart:async';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';

class LocalDB {
  static late final Isar _isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [BoardSchema],
      directory: dir.path,
    );
  }

  static Future<bool> restore() async {
    return await _isar.close(deleteFromDisk: true);
  }

  static Future<void> addBoard(Board board) async {
    await _isar.writeTxn(() async {
      await _isar.boards.put(board);
    });
  }

  static Future<void> editBoard(Board board) async {
    await _isar.writeTxn(() async {

      print('board : ${board}');
      await _isar.boards.put(board);
    });
  }

  static Future<List<Board>> getBoardList() async {
    return await _isar.boards.where().sortByCreatedAtDesc().findAll();
  }

  static Future<Board?> getBoard(Id boardId) {
    return _isar.boards.get(boardId);
  }

  static Future<void> removeBoard(Id boardId) async {
    await _isar.writeTxn(() async {
      await _isar.boards.delete(boardId);
    });
  }

  static Future<List<BoardComment>?> getBoardComments(Id boardId) async {
    return await _isar.boards.where().idEqualTo(boardId).commentsProperty().findFirst();
    // TODO : 중첩된 리스트를 가져올 때에는 어떻게 할지 고민해보자...
    // TODO : 댓글을 가져올 때 sort 하여 가져와보자.

  }

  static Future<void> addComment(Id boardId, BoardComment comment) async {

    Board? board = await _isar.boards.get(boardId);

    await _isar.writeTxn(() async {

      if(board != null) {
        try {
          if(board.comments != null) {
            List<BoardComment>? comments = board.comments!.toList();
            comments.add(comment);
            board.comments = comments;
          }else {
            board.comments = List.of([comment]);
          }
        } catch(e, s) {
          print('Exception details : \n $e');
          print('Stack trace : \n $s');
        }

        await _isar.boards.put(board);
      }
    });
  }
}
