import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/screen/main/tab/board/f_board.riverpod.dart';

import '../vo/vo_board.dart';

class WriteBoardScreen extends ConsumerStatefulWidget {
  const WriteBoardScreen({super.key});

  @override
  ConsumerState<WriteBoardScreen> createState() => _WriteBoardScreenState();
}

class _WriteBoardScreenState extends ConsumerState<WriteBoardScreen> {
  final TextEditingController contentController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ref.read(boardsProvider.notifier).addBoard(Board(
                    _textEditingController.text,
                    contentController.text,
                    createdBy: '김동욱'));
                Navigator.pop(context);
              }
            },
            child: const Text('저장')),
      ],),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1.0,
                    width: MediaQuery.of(context).size.width * 1.0,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(border: InputBorder.none),
                      maxLines: 100,
                      controller: contentController,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    contentController.dispose();
    super.dispose();
  }
}
