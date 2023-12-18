import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/mail/vo/vo_mail.dart';
import 'package:playground/screen/main/tab/mail/vo/vo_mail_dummy.dart';

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
    return SingleChildScrollView(
        child: Column(
            children: _mailList
                .map((mail) => Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 0.5,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(mail.from),
                                Text(mail.content), // TODO : 메일 내용의 길이가 길면 화면을 벗어나 오류가 발생하므로 특정 길이를 벗어나면, 이후 내용은 생략되도록 해보자.
                              ],
                            ),
                            Spacer(),
                            Text(mail.createdAt.toString()), // TODO : 시간이 너무 자세하게 나와 화면에서 너무 많이 차지하므로 이 또한 어느정도 생략 필요
                          ],
                        ),
                      ),
                    ))
                .toList()));
  }
}
