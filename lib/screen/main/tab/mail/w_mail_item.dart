import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/mail/s_mail_detail.dart';
import 'package:playground/screen/main/tab/mail/vo/vo_simple_mail.dart';

class MailItem extends StatefulWidget {
  final SimpleMail mail;

  const MailItem({required this.mail, super.key});

  @override
  State<MailItem> createState() => _MailItemState();
}

class _MailItemState extends State<MailItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MailDetail(id: widget.mail.id))) ,
      child: Container(
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
                  Text(widget.mail.from),
                  Text(widget.mail.content), // TODO : 메일 내용의 길이가 길면 화면을 벗어나 오류가 발생하므로 특정 길이를 벗어나면, 이후 내용은 생략되도록 해보자.
                ],
              ),
              const Spacer(),
              Text(widget.mail.createdAt.toString()), // TODO : 시간이 너무 자세하게 나와 화면에서 너무 많이 차지하므로 이 또한 어느정도 생략 필요
            ],
          ),
        ),
      ),
    );
  }
}