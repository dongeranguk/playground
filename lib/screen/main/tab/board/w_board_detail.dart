import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
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

  const BoardDetail(
      {required this.board,
      required this.comments,
      required this.callback,
      super.key});

  @override
  State<BoardDetail> createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> with AfterLayoutMixin {
  late Board _board;
  late List<BoardComment> _comments;
  final QuillController _controller = QuillController.basic();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _board = widget.board;
    _comments = widget.comments;

    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    _board.isRead = !_board.isRead;
    List<dynamic> jsonData = jsonDecode(_board.content);
    _controller.document = Document.fromJson(jsonData);

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
              !_controller.document.isEmpty()
                  ? RoundedContainer(
                      height: 500,
                      width: 500,
                      child: QuillEditor(
                          scrollController: _scrollController,
                          focusNode: _focusNode,
                          configurations: QuillEditorConfigurations(
                              controller: _controller,
                              readOnly: true,
                              autoFocus: false,
                              expands: true,
                              scrollable: true,
                              showCursor: false)),
                    )
                  : RoundedContainer(
                      height: 500,
                      width: 500,
                      child: Text(_board.content.toString()),
                    ),
              // TODO : QuillController 를 넘겨주어 QuillEditor로 작성한 json 형식으로 인코딩된 글을 가져올 수 있었지만,
              // QuillEditor로 작성하지 않은 글의 경우 가져올 때 오류가 발생하므로 분기 처리하여 보여주어야 함.
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
