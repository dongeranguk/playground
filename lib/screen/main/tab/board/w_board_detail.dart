import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_comment.dart';

import 'package:playground/common/common.dart';

class BoardDetail extends StatefulWidget {
  final Board board;
  final List<BoardComment> comments;

  const BoardDetail({required this.board, required this.comments, super.key});

  @override
  State<BoardDetail> createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> {
  late Board _board;
  late List<BoardComment> _comments;

  @override
  void initState() {
    _board = widget.board;
    _comments = widget.comments;
    super.initState();
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
      floatingActionButton: IconButton(
        icon: Icon(CupertinoIcons.add_circled, size: 50,),
        onPressed: () {
          // TODO : 클릭 시 기능 리스트 보여지도록 구현
        },
      ),
    );
  }
}
