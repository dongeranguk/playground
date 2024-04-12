import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/app.dart';

import '../vo/vo_board.dart';
import '../vo/vo_write_board_result.dart';

class WriteBoardScreen extends StatefulWidget {
  final Board? boardForEdit;

  const WriteBoardScreen({this.boardForEdit, super.key});

  @override
  State<WriteBoardScreen> createState() => _WriteBoardScreenState();
}

class _WriteBoardScreenState extends State<WriteBoardScreen> {
  final contentEditingController = TextEditingController();
  final titleEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (isEditMode) {
      contentEditingController.text = widget.boardForEdit!.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if(isWriteMode) {
                  if(!_formKey.currentState!.validate()) return;
                }
                navigatorKey.currentState!.pop(WriteBoardResult(titleEditingController.text, contentEditingController.text));
              },
              child: const Text('저장')),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isWriteMode ? Form(
              key: _formKey,
              child: TextFormField(
                controller: titleEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '제목을 입력해주세요.';
                  }
                  return null;
                },
              ),
            ) : const SizedBox(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1.0,
              width: MediaQuery.of(context).size.width * 1.0,
              child: TextField(
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(border: InputBorder.none),
                maxLines: 100,
                controller: contentEditingController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get isWriteMode => widget.boardForEdit == null;
  bool get isEditMode => widget.boardForEdit != null;

  @override
  void dispose() {
    titleEditingController.dispose();
    contentEditingController.dispose();
    super.dispose();
  }
}
