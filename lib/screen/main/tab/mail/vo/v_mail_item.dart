import 'dart:convert';

import 'package:googleapis/gmail/v1.dart';

class Mail {

  String id;
  String threadId;
  List<String> labelIds;
  String snippet;
  String historyId;
  String internalDate;
  MessagePart? payload;
  int sizeEstimate;
  String raw;

  Mail.fromJson(Map<String, dynamic> json) :
      id = json['id'] as String,
      threadId = json['threadId'],
      labelIds = json['labelIds'] as List<String>,
      snippet = json['snippet'],
      historyId = json['historyId'] as String,
      internalDate = json['internalDate'] as String,
      payload = json['payload'],
      sizeEstimate = json['sizeEstimate'] as int,
      raw = utf8.decode(base64Decode(json['raw']))
  ;


}

