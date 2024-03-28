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
          Flexible(
            child: Text(widget.board.title,
                overflow: TextOverflow.ellipsis,
                style:  TextStyle(fontSize: 17, fontWeight: _board.isRead ? FontWeight.normal : FontWeight.bold)),
          ),
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
