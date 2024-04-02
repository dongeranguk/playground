import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:playground/screen/main/tab/board/f_board.riverpod.dart';
import 'package:playground/screen/main/tab/board/screen/s_write_board.dart';
import 'package:playground/screen/main/tab/board/w_board_item.dart';

import 'vo/vo_board.dart';

class BoardFragment extends ConsumerStatefulWidget {
  final String tabName;

  const BoardFragment({required this.tabName, super.key});

  @override
  ConsumerState<BoardFragment> createState() => _BoardFragmentState();
}

class _BoardFragmentState extends ConsumerState<BoardFragment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final boards = ref.watch(boardsProvider);

    return Scaffold(
        body: switch (boards) {
          AsyncError(:final error) => Text('Error : $error'),
          AsyncData(:final value) => ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) =>
                  BoardItem(value[index])),
          _ => const CircularProgressIndicator(),
        },
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const WriteBoardScreen()));
            }));
  }

  void removeBoard(Id boardId) {
    setState(() {});
  }

  void setRead(int boardId) {
    setState(() {});
  }

// List<BoardComment> getCommentsByBoardId(int id) {
//   return boardCommentList.where((element) => element.boardId == id).toList();
// }
}
