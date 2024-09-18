import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:googleapis/gmail/v1.dart';

import 'vo/v_mail_item.dart';

class MailItem extends StatelessWidget {
  final String raw;

  const MailItem({required this.raw, super.key});

  @override
  Widget build(BuildContext context) {
    /***
     * TODO : List<Header> 의 headers 를 Map 형태로 만들어서 key 로 값을 가져와서 가독성을 높여보자.
     * TODO : 값이 null 인 경우 null 처리를 해주자.
     */

    return Scaffold(
        appBar: AppBar(),
        body: Text(utf8.decode(base64Decode(raw ?? ''))));
    // return ListTile(
    //   title: Text(widget.mail.headers![4].value),
    //   subtitle: Text(widget.mail.headers![3].value),
    //   leading: Checkbox(
    //     value: _isChecked[_index],
    //     onChanged: (value) => setState(() {
    //       _isChecked[_index] = value!;
    //     }),
    //   ),
    //   onTap: null,
    // ); // onTap 이벤트 호출 시 메일 상세 화면 보여주기
  }
}
