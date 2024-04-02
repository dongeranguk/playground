import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/common/data/local/local_db.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'f_board.riverpod.g.dart';

// final boardsProvider = FutureProvider<List<Board>>((ref) => LocalDB.getBoardList());

@riverpod
class Boards extends _$Boards {
  Future<List<Board>> _fetchBoard() async {
    return await LocalDB.getBoardList();
  }

  @override
  FutureOr<List<Board>> build() async {
    return _fetchBoard();
  }

  Future<void> addBoard(Board board) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await LocalDB.addBoard(board);
      return _fetchBoard();
    });
  }

  Future<void> removeBoard(int boardId) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await LocalDB.removeBoard(boardId);
      return _fetchBoard();
    });
  }

  Future<void> setRead(int boardId) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await LocalDB.getBoard().then((value) => value?.isRead = true);

      return _fetchBoard();
    });
  }

}