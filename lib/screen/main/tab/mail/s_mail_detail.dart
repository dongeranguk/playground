import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playground/common/dart/extension/date_extension.dart';
import 'package:playground/screen/main/tab/mail/vo/vo_mail.dart';
import 'package:playground/screen/main/tab/mail/vo/vo_mail_dummy.dart';

class MailDetail extends StatefulWidget {
  final int id;
  final VoidCallback voidCallback;

  const MailDetail({required this.id, required this.voidCallback, super.key});

  @override
  State<MailDetail> createState() => _MailDetailState();
}

class _MailDetailState extends State<MailDetail> with AfterLayoutMixin {
  late Mail _mail;
  late bool _isRead;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    widget.voidCallback.call();
  }

  @override
  void initState() {
    _mail = mailList[widget.id];
    _isRead = _mail.isRead;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _mail = mailList[widget.id];
    final List<Widget> actions = [
      IconButton(
        icon: const Icon(CupertinoIcons.arrowshape_turn_up_left_fill),
        onPressed: () {},
      ),
      _isRead
          ? IconButton(
              icon: const Icon(CupertinoIcons.envelope_open),
              onPressed: () {
                setState(() {
                  _isRead = !_isRead;
                  mailList[widget.id].isRead = _isRead;
                });
                widget.voidCallback.call();
              })
          : IconButton(
              icon: const Icon(CupertinoIcons.envelope),
              onPressed: () {
                setState(() {
                  _isRead = !_isRead;
                  mailList[widget.id].isRead = _isRead;
                });
                widget.voidCallback.call();
              }),
      IconButton(
        icon: const Icon(CupertinoIcons.delete),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('삭제하시겠어요?'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () => Navigator.popUntil(
                                    context, (route) => route.isFirst),
                                child: Text('네')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('아니오'))
                          ],
                        )
                      ],
                    ),
                  ));
        },
      ),
      IconButton(
        icon: const Icon(CupertinoIcons.ellipsis_vertical),
        onPressed: () {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: actions,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: Text(_mail.title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold))),
            const SizedBox(height: 5),
            LabeledRoundedContainer(
              label: '보낸사람',
              value: _mail.to,
            ),
            const SizedBox(height: 5),
            LabeledRoundedContainer(
              label: '받는사람',
              value: _mail.from,
            ),
            const SizedBox(height: 10),
            Text(_mail.createdAt.formattedDateTime),
            const SizedBox(height: 50),
            Text(_mail.content),
          ],
        ),
      ),
    );
  }
}

class LabeledRoundedContainer extends StatelessWidget {
  final String label;
  final String value;

  const LabeledRoundedContainer(
      {required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 13)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lightBlueAccent.shade100),
            child: Text(value),
          ),
        )
      ],
    );
  }
}
