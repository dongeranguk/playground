import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_comment.dart';
import 'package:playground/screen/main/tab/board/w_board_detail.dart';

class BoardItem extends StatefulWidget {
  final Board board;
  final List<BoardComment> comments;

  const BoardItem(this.board, this.comments, {super.key});

  @override
  State<BoardItem> createState() => _BoardItemState();
}

class _BoardItemState extends State<BoardItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(widget.board.title, style: const TextStyle(fontSize: 17)), // TODO : 읽은 글일 경우 읽은 글임을 나타내는 TextStyle로 스위칭
          const SizedBox(width: 10),
          Text(
            widget.comments.length.toString(),
            style: const TextStyle(fontSize: 12, color: Colors.blue),
          )
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BoardDetail(board: widget.board, comments: widget.comments),
        ),
      ),
    );
  }
}

