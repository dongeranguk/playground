import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/common/dart/extension/date_extension.dart';
import 'package:playground/common/widget/w_rounded_container.dart';
import 'package:playground/screen/main/tab/board/f_board.riverpod.dart';
import 'package:playground/screen/main/tab/board/f_board_comment.riverpod.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';

import '../../../../../common/common.dart';
import '../../../write/w_write_board_comment.dart';
import '../w_board_comment.dart';

class BoardDetail extends ConsumerStatefulWidget {
  final Board board;

  const BoardDetail({required this.board, super.key});

  @override
  ConsumerState<BoardDetail> createState() => _BoardDetailState();
}

class _BoardDetailState extends ConsumerState<BoardDetail> {
  late Board _board;

  @override
  void initState() {
    _board = widget.board;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentsProvider(_board.id));
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                title: Text(_board.title!),
                actions: [
                ],
              ),
              SliverToBoxAdapter(child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        ref.read(boardsProvider.notifier).editBoard(_board); // TODO : 글 작성 화면과 비슷하므로 글 작성 위젯을 재활용할 수 있도록 해보자.
                      },
                      child: const Text('수정')),
                  TextButton(
                      onPressed: () {
                        ref.read(boardsProvider.notifier).removeBoard(_board.id);
                        // Navigator.pop(context);
                      },
                      child: const Text('삭제')),
                ],),),
              SliverToBoxAdapter(child: Line),
              SliverToBoxAdapter(
                  child: Markdown(
                data: _board.content,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15),
              )),
              SliverToBoxAdapter(child: Line),
              switch (comments) {
                AsyncError(:final error) =>
                  SliverToBoxAdapter(child: Text('Error : $error')),
                AsyncData(:final value) => (value == null || value.isEmpty)
                    ? const SliverToBoxAdapter(child: Text('댓글이 없어요.'))
                    : SliverList(
                        delegate: SliverChildListDelegate(value.reversed
                            .map((e) => BoardCommentWidget(e))
                            .toList())),
                _ =>
                  const SliverToBoxAdapter(child: CircularProgressIndicator()),
              },
            ],
          ),
          WriteBoardCommentWidget(boardId: _board.id),
        ],
      ),
    );
  }
}
