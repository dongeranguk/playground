import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';

class BoardCommentWidget extends StatelessWidget {
  final BoardComment comment;

  const BoardCommentWidget(this.comment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text('${comment.content}'),
      ],),
    );
  }
}
