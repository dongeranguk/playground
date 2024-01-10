import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:playground/screen/main/tab/board/screen/s_write_board.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_comment_list.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_list.dart';
import 'package:playground/screen/main/tab/board/w_board_item.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_comment.dart';

import 'vo/vo_board.dart';

class BoardFragment extends StatefulWidget {
  final String tabName;

  const BoardFragment({required this.tabName, super.key});

  @override
  State<BoardFragment> createState() => _BoardFragmentState();
}

class _BoardFragmentState extends State<BoardFragment> {

  late QuillController _controller;

  @override
  void initState() {
    _controller = QuillController.basic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate(
              boardList.reversed
                  .map((e) => BoardItem(e, getCommentsByBoardId(e.id)))
                  .toList(),
            ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WriteBoardScreen(callback: addBoard)));
            }));
  }

  void addBoard(Board board) {
    boardList.add(board);
    setState(() {});
  }

  List<BoardComment> getCommentsByBoardId(int id) {
    return boardCommentList.where((element) => element.boardId == id).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
