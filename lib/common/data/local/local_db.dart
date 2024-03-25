import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';

import '../BoardRepository.dart';

class LocalDB implements BoardRepository {
  static late final Isar _isar;

  LocalDB._();

  static LocalDB instance = LocalDB._();

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [BoardSchema],
      directory: dir.path,
    );
  }

  @override
  Future<void> addBoard(Board board) async {
    await _isar.writeTxn(() async {
      await _isar.boards.put(board);
    });
  }

  @override
  Future<List<Board>> getBoardList() async {
    return await _isar.boards.where().findAll();
  }

  @override
  Future<Board?> getBoard() {
    return _isar.boards.get(1).then((value) => value);
  }

  @override
  Future<void> removeBoard(Id boardId) async {
    print('boardId : $boardId');
    await _isar.writeTxn(() async {
      await _isar.boards.delete(boardId);
    });
  }

}
