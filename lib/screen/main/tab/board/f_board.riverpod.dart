import 'package:flutter/material.dart';
import 'package:playground/app.dart';
import 'package:playground/common/data/local/local_db.dart';
import 'package:playground/screen/main/tab/board/screen/s_write_board.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';
import 'package:playground/screen/main/tab/board/vo/vo_write_board_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'f_board.riverpod.g.dart';

@riverpod
class Boards extends _$Boards {
  Future<List<Board>> _fetchBoard() async {
    return await LocalDB.getBoardList();
  }

  @override
  FutureOr<List<Board>> build() async {
    return _fetchBoard();
  }

  Future<void> addBoard() async {

    final WriteBoardResult result = await navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const WriteBoardScreen()));

    if(result != null) {
      state = await AsyncValue.guard(() async {

        await LocalDB.addBoard(Board(result.title, result.content, createdBy: '김동욱'));

        if(navigatorKey.currentContext!.mounted) {
          ScaffoldMessenger.of(navigatorKey.currentContext!)..removeCurrentSnackBar()..showSnackBar(const SnackBar(content: Text('저장되었어요.')));
        }

        return _fetchBoard();
      });
    }
  }
  
  Future<void> editBoard(Board board) async {
    final WriteBoardResult result = await navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => WriteBoardScreen(boardForEdit: board)));

    if(result != null) {
      state = await AsyncValue.guard(() async {
        board.updatedAt = DateTime.now();
        board.content = result.content;

        await LocalDB.editBoard(board);
        
        if(navigatorKey.currentState!.mounted) {
          ScaffoldMessenger.of(navigatorKey.currentContext!)..removeCurrentSnackBar()..showSnackBar(const SnackBar(content: Text('수정되었어요.')));
        }

        return _fetchBoard();
      });
    }
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