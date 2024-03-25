import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_comment.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_list.dart';
import 'package:playground/screen/main/tab/board/w_board_detail.dart';

class BoardItem extends StatefulWidget {
  final Board board;
  // final List<BoardComment> comments;
  final Function(int) callback;

  const BoardItem(this.board, {super.key, required this.callback});

  @override
  State<BoardItem> createState() => _BoardItemState();
}

class _BoardItemState extends State<BoardItem> {
  late Board _board;

  @override
  void initState() {
    _board = widget.board;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(widget.board.title,
              style: (_board.isRead)
                  ? const TextStyle(fontSize: 17, fontWeight: FontWeight.normal)
                  : const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          // TODO : 읽은 글일 경우 읽은 글임을 나타내는 TextStyle로 스위칭
          const SizedBox(width: 10),
          // Text(
          //   widget.comments.length.toString(),
          //   style: const TextStyle(fontSize: 12, color: Colors.blue),
          // )
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BoardDetail(
              board: widget.board,
              // comments: widget.comments,
              callback: setRead,
              callback2: widget.callback),
        ),
      ),
    );
  }

  void setRead() {
    if (boardList[_board.id].isRead != _board.isRead && _board.isRead) {
      setState(() {
      });
    }
  }
}
