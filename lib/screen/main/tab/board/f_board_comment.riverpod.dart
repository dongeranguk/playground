import 'package:playground/common/data/local/local_db.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';
import 'package:riverpod/src/framework.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'f_board_comment.riverpod.g.dart';

@riverpod
class Comments extends _$Comments {

  Future<List<BoardComment>?> _fetchBoardComments(int boardId) async {
      return await LocalDB.getBoardComments(boardId);
  }

  @override
  FutureOr<List<BoardComment>?> build(int boardId) {
    return _fetchBoardComments(boardId);
  }

  Future<void> addComment(int boardId, BoardComment comment) async {

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await LocalDB.addComment(boardId, comment);

      return _fetchBoardComments(boardId);
    });
  }

}