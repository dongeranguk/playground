import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/screen/main/tab/board/screen/s_board_detail.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';

class BoardItem extends ConsumerWidget {
  final Board _board;
  // final List<BoardComment> comments;

  const BoardItem(this._board, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Row(
        children: [
          Flexible(
            child: Text(_board.title,
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
              board: _board,
              // comments: widget.comments),
        ),
      ),
    ));
  }
}
