import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_comment_list.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_list.dart';
import 'package:playground/screen/main/tab/board/w_board_item.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_comment.dart';

class BoardFragment extends StatelessWidget {
  final String tabName;

  const BoardFragment({required this.tabName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate(
                  boardList
                      .map((e) => BoardItem(e, getCommentsByBoardId(e.id)))
                      .toList(),
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () {}));
  }

  List<BoardComment> getCommentsByBoardId(int id) {
    return boardCommentList.where((element) => element.boardId == id).toList();
  }
}
