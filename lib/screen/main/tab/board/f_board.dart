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
    return CustomScrollView(
      slivers: [
        SliverList(delegate: SliverChildListDelegate(
          boardList.map((e) => BoardItem(e, getCommentsByBoardId(e.id))).toList(),
        )
        )
      ],
    );
  }

  List<BoardComment> getCommentsByBoardId(int id) {
    return boardCommentList.where((element) => element.boardId == id).toList();
  }
}
//
// return CustomScrollView(
// slivers: [
// SliverList(
// delegate: SliverChildBuilderDelegate(
// (context, index) => BoardItem(
// boardList[index],
// // TODO : builder에서 제공하는 index로 게시글을 찾았지만,
// // 만약 게시글이 추가되면 추가된 게시글은 맨 아래에 위치하게 될텐데, 역순으로 정렬할 수는 없을 지 생각해보자.
// boardCommentList.where(
// (element) => element.boardId == boardList[index].id).toList()),
// // WhereIterable 은 Iterable 의 자식 객체여서, toList 함수 사용 가능하므로 toList 함수 호출하여 List에 캐스팅
// childCount: boardList.length))
// ],
// // child: Column(
// //   children: boardList.map((e) => BoardItem(e)).toList(),
// // ),
// );
