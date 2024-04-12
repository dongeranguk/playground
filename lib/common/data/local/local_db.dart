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

      await _isar.boards.put(board);
    });
  }

  static Future<List<Board>> getBoardList() async {
    return await _isar.boards.where().sortByCreatedAtDesc().findAll();
  }

  static Future<Board?> getBoard() {
    return _isar.boards.get(1).then((value) => value);
  }

  static Future<void> removeBoard(Id boardId) async {
    await _isar.writeTxn(() async {
      await _isar.boards.delete(boardId);
    });
  }

}
