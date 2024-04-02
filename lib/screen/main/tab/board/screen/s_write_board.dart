import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/screen/main/tab/board/f_board.riverpod.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_list.dart';

import '../vo/vo_board.dart';

class WriteBoardScreen extends ConsumerStatefulWidget {

  const WriteBoardScreen({super.key});

  @override
  ConsumerState<WriteBoardScreen> createState() => _WriteBoardScreenState();
}

class _WriteBoardScreenState extends ConsumerState<WriteBoardScreen> {
  final QuillController _controller = QuillController.basic();
  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SingleChildScrollView(
            child: QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                  controller: _controller,
                  sharedConfigurations:
                      const QuillSharedConfigurations(locale: Locale('ko'))),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _textEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '제목을 입력해주세요.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                  controller: _controller,
                  readOnly: false,
                  sharedConfigurations:
                      const QuillSharedConfigurations(locale: Locale('ko'))),
            ),
          ),
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(boardsProvider.notifier).addBoard(Board(_textEditingController.text, jsonEncode(_controller.document.toDelta().toJson()), createdBy: '김동욱'));
                  Navigator.pop(context);
                }
              },
              child: const Text('저장')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
