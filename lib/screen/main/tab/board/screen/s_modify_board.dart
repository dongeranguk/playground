import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';

class ModifyBoardScreen extends StatefulWidget {
  final Board board;
  final Function(String) callback;

  const ModifyBoardScreen(
      {required this.board,
      required this.callback,
      super.key});

  @override
  State<ModifyBoardScreen> createState() => _ModifyBoardScreenState();
}

class _ModifyBoardScreenState extends State<ModifyBoardScreen> {
  late Board _board;
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    _board = widget.board;
    contentController.text = _board.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () {
              widget.callback.call(contentController.text);
              Navigator.pop(context);
            },
            child: const Text('저장')),
      ],),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
    );
  }
}
