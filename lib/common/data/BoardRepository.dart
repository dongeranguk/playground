import 'package:isar/isar.dart';

import '../../screen/main/tab/board/vo/vo_board.dart';

abstract interface class BoardRepository {
  Future<void> addBoard(Board board);

  Future<List<Board>> getBoardList();

  Future<Board?> getBoard();

  Future<void> removeBoard(Id boardId);
}