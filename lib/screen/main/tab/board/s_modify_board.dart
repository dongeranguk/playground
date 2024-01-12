import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:playground/screen/main/tab/board/f_board.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';
import 'package:playground/screen/main/tab/board/w_board_detail.dart';

class ModifyBoardScreen extends StatefulWidget {
  final Board board;
  final QuillController controller;
  final Function(int, String) callback;

  const ModifyBoardScreen(
      {required this.board,
      required this.controller,
      required this.callback,
      super.key});

  @override
  State<ModifyBoardScreen> createState() => _ModifyBoardScreenState();
}

class _ModifyBoardScreenState extends State<ModifyBoardScreen> {
  late Board _board;
  late String _title;
  late QuillController _controller;
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _board = widget.board;
    _title = _board.title;
    _controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                  controller: _controller,
                  sharedConfigurations:
                      const QuillSharedConfigurations(locale: Locale('ko')))),
          // Form(
          //   key: _formKey,
          //   child: Stack(
          //     alignment: Alignment.centerLeft,
          //     children: [
          //       TextFormField(
          //         controller: _textEditingController,
          //         validator: (value) {
          //           if (value == null || value.isEmpty) {
          //             return '제목을 입력해주세요.';
          //           }
          //           return null;
          //         },
          //       ),
          //     ],
          //   ),
          // ), TODO : 제목도 수정할 수 있도록 만들어보자.
          Expanded(
            child: QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                controller: _controller,
              ),
              focusNode: _focusNode,
            ),
          ),
          TextButton(
              onPressed: () {
                widget.callback.call(_board.id, jsonEncode(_controller.document.toDelta().toJson()));
                Navigator.pop(context);
              },
              child: const Text('저장')),
        ],
      ),
    );
  }
}
