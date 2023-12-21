import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playground/screen/main/tab/mail/vo/vo_mail_dummy.dart';

class MailDetail extends StatelessWidget {
  final int id;

  const MailDetail({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    final _mail = mailList[id];
    final List<Widget> _actions = [
      const Icon(CupertinoIcons.arrowshape_turn_up_left_fill),
      _mail.isRead
          ? const Icon(CupertinoIcons.envelope_open)
          : const Icon(CupertinoIcons.envelope),
      const Icon(CupertinoIcons.delete),
      const Icon(CupertinoIcons.ellipsis_vertical),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('메일'),
        actions: _actions, // TODO : _actions 아이콘마다 패딩 값 주기
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
            Text(DateFormat('yyyy년 MM월 dd일 HH:mm:ss').format(_mail.createdAt)),
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
