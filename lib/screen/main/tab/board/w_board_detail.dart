import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_comment.dart';
import 'package:after_layout/after_layout.dart';

import 'package:playground/common/common.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_list.dart';

const List<String> list = ['첫번째', '두번째', '세번째'];

class BoardDetail extends StatefulWidget {
  final Board board;
  final List<BoardComment> comments;
  final VoidCallback callback;

  const BoardDetail({required this.board, required this.comments, required this.callback, super.key});

  @override
  State<BoardDetail> createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> with AfterLayoutMixin {
  late Board _board;
  late List<BoardComment> _comments;
  @override
  void initState() {
    _board = widget.board;
    _comments = widget.comments;

    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    _board.isRead = !_board.isRead;
    widget.callback.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_board.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              RoundedContainer(
                  height: 500, width: 500, child: Text(_board.content)),
              Column(
                children: _comments
                    .map((e) => Row(children: [
                          Text(e.commentId.toString()),
                          const SizedBox(width: 10),
                          Text(e.content),
                        ]))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// IconButton(
// icon: const Icon(
// CupertinoIcons.add_circled,
// size: 50,
// ),
// onPressed: () {
// // TODO : 클릭 시 기능 리스트 보여지도록 구현
// print('dropdown item');
// DropdownButton(
// value: dropdownValue,
// elevation: 1,
// items: [
// DropdownMenuItem(
// value: list.first,
// child: Container(
// child: Text('1'),
// )),
// DropdownMenuItem(
// value: list[1],
// child: Container(
// child: Text('2'),
// )),
// DropdownMenuItem(
// value: list[2],
// child: Container(
// child: Text('2'),
// )),
// ],
// onChanged: (value) {
// if (value == null) {
// return;
// }
//
// setState(() {
// dropdownValue = value;
// });
// },
// );
// },
// ),