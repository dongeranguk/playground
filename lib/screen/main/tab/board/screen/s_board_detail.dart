import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/common/dart/extension/date_extension.dart';
import 'package:playground/screen/main/tab/board/f_board.riverpod.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';

class BoardDetail extends ConsumerStatefulWidget {
  final Board board;

  // final List<BoardComment> comments;

  const BoardDetail(
      {required this.board,
      // required this.comments,
      super.key});

  @override
  ConsumerState<BoardDetail> createState() => _BoardDetailState();
}

class _BoardDetailState extends ConsumerState<BoardDetail>
    with AfterLayoutMixin {
  late Board _board;

  // late List<BoardComment> _comments;

  @override
  void initState() {
    _board = widget.board;
    // _comments = widget.comments;

    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    _board.isRead = !_board.isRead;

    ref.read(boardsProvider.notifier).setRead(_board.id);
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
              Text(_board.title!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Row(
                children: [
                  Column(
                    children: [
                      Text(_board.createdAt.formattedDateTime),
                      _board.updatedAt != null
                          ? Text(_board.updatedAt!.formattedDateTime)
                          : const Text(''),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        ref.read(boardsProvider.notifier).editBoard(_board); // TODO : 글 작성 화면과 비슷하므로 글 작성 위젯을 재활용할 수 있도록 해보자.
                      },
                      child: const Text('수정')),
                  TextButton(
                      onPressed: () {
                        ref.read(boardsProvider.notifier).removeBoard(_board.id);
                        Navigator.pop(context);
                      },
                      child: const Text('삭제')),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 1.0,
                  width: MediaQuery.of(context).size.width * 1.0,
                  child: Markdown(data: _board.content)),
              // Column(
              //   children: _comments
              //       .map((e) => Row(children: [
              //             Text(e.commentId.toString()),
              //             Text(e.content),
              //           ]))
              //       .toList(),
              // )
            ],
          ),
        ),
      ),
    );
  }

  void modifyBoard(String content) {
    setState(() {
      _board.content = content;
      _board.updatedAt = DateTime.now();
    });
  }
}
