import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/screen/main/tab/board/f_board_comment.riverpod.dart';
import 'package:playground/screen/main/tab/board/vo/vo_board.dart';

class WriteBoardCommentWidget extends ConsumerWidget {
  final int boardId;
  const WriteBoardCommentWidget({required this.boardId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = TextEditingController();
    final scrollController = ScrollController();
    return Positioned(bottom: 5, left: 5, right: 5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300,
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: 5, vertical: 10),
                child: TextField(
                  minLines: 1,
                  maxLines: 4,
                  controller: commentController,
                  scrollController: scrollController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if(commentController.text.isEmpty) return;
                          ref.read(commentsProvider(boardId).notifier).addComment(boardId, BoardComment(content: commentController.text, createdBy: '김동욱'));
                        },
                      ),
                      hintText: '댓글을 추가해보세요.',
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                )),
          ],
        ),
      ),
    );
  }
}
