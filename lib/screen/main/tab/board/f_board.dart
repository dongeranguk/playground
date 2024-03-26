import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playground/common/data/BoardRepository.dart';
import 'package:playground/common/data/local/local_db.dart';
import 'package:playground/screen/main/tab/board/screen/s_write_board.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_comment_list.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_list.dart';
import 'package:playground/screen/main/tab/board/w_board_item.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board_comment.dart';

import 'vo/vo_board.dart';

class BoardFragment extends StatefulWidget {
  final String tabName;

  const BoardFragment({required this.tabName, super.key});

  @override
  State<BoardFragment> createState() => _BoardFragmentState();
}

class _BoardFragmentState extends State<BoardFragment> {
  final BoardRepository boardRepository = LocalDB.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: boardRepository.getBoardList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final boards = snapshot.data;



              if (boards != null) {
                return ListView.builder(
                    itemCount: boards.length,
                    itemBuilder: (context, index) {
                      return BoardItem(boards[index], callback: removeBoard);
                    });
              }
            }
            if(snapshot.connectionState != ConnectionState.done){
              return const CircularProgressIndicator();
            }
            return const Text('등록된 글이 없어요.');
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WriteBoardScreen(callback: addBoard)));
            }));
  }

  void addBoard(Board board) {
    setState(() {
      boardList.add(board);
      boardRepository.addBoard(board);
    });
  }

  void removeBoard(Id boardId) {
    setState(() {
      boardRepository.removeBoard(boardId);
    });
  }

  void setRead(int boardId) {
    setState(() {

    });
  }

  // List<BoardComment> getCommentsByBoardId(int id) {
  //   return boardCommentList.where((element) => element.boardId == id).toList();
  // }
}
