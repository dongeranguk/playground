import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playground/screen/main/tab/mail/s_mail_write.dart';
import 'package:playground/screen/main/tab/mail/vo/vo_mail.dart';
import 'package:playground/screen/main/tab/mail/vo/vo_mail_dummy.dart';
import 'package:playground/screen/main/tab/mail/vo/vo_simple_mail.dart';
import 'package:playground/screen/main/tab/mail/w_mail_item.dart';

class MailFragment extends StatefulWidget {
  final String tabName;

  const MailFragment({required this.tabName, super.key});

  @override
  State<MailFragment> createState() => _MailFragmentState();
}

class _MailFragmentState extends State<MailFragment> {
  late String _tabName;
  late List<Mail> _mailList;

  @override
  void initState() {
    _tabName = widget.tabName;
    _mailList = mailList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: _mailList
              .map(
                (element) => MailItem(
                    mail: SimpleMail(
                  element.id,
                  element.from,
                  element.content,
                  DateFormat('yyyy년 MM월 dd일 hh:mm:dd').format(element.createdAt),
                )),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(CupertinoIcons.pencil_circle),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WriteMailScreen()));
        },
      ),
    );
  }
}
