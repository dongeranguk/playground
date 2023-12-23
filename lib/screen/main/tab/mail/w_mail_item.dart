import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:playground/common/dart/extension/date_extension.dart';
import 'package:playground/screen/main/tab/mail/s_mail_detail.dart';
import 'package:playground/screen/main/tab/mail/vo/vo_mail_dummy.dart';
import 'package:playground/screen/main/tab/mail/vo/vo_simple_mail.dart';

class MailItem extends StatefulWidget {
  final SimpleMail mail;

  const MailItem({required this.mail, super.key});

  @override
  State<MailItem> createState() => _MailItemState();
}

class _MailItemState extends State<MailItem> {
  late String content;
  late bool _isRead;
  late TextStyle mailStyle;

  @override
  void initState() {
    content = widget.mail.content.length > 15
        ? '${widget.mail.content.substring(0, 15)}...'
        : widget.mail.content;

    _isRead = widget.mail.isRead;

    if (!_isRead) {
      mailStyle = const TextStyle(fontWeight: FontWeight.bold);
    } else {
      mailStyle = const TextStyle();
    }

    super.initState();
  }

  void setRead() => setState(() {
        if (_isRead != mailList[widget.mail.id].isRead) {
          _isRead = !_isRead;
        }

        if (!_isRead) {
          mailStyle = const TextStyle(fontWeight: FontWeight.bold);
        } else {
          mailStyle = const TextStyle();
        }
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mailList[widget.mail.id].isRead = true;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MailDetail(
                      id: widget.mail.id,
                      voidCallback: setRead,
                    )));
      },
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
                  Text(
                    widget.mail.from,
                    style: mailStyle,
                  ),
                  Text(
                    content,
                    style: mailStyle,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                widget.mail.createdAt.customFormat(),
                style: mailStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
