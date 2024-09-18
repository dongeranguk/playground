import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/app.dart';
import 'package:playground/screen/main/tab/mail/f_mail.riverpod.dart';
import 'package:playground/screen/main/tab/mail/w_mail_item.dart';

class MailFragment extends ConsumerWidget {
  final String tabName;

  const MailFragment({super.key, required this.tabName});

  Widget build(BuildContext context, WidgetRef ref) {
    final mailState = ref.watch(userMailsProvider);

    return Scaffold(
      body: mailState.when(
        data: (mailList) => NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              ref.read(userMailsProvider.notifier).fetchNextPage();
            }
            return false;
          },
          child: ListView.builder(
              itemCount: mailList.length,
              itemBuilder: (context, index) {
                final mail = mailList[index];
                return FutureBuilder(
                    future: ref
                        .read(userMailsProvider.notifier)
                        .fetchMessageDetail(mail.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListTile(title: Text('Loading...'));
                      } else if (snapshot.hasError) {
                        return ListTile(
                            title: Text('Error : ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final message = snapshot.data!;
                        return ListTile(
                            title: Text(
                                message.snippet ?? 'No snippet available'),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MailItem(raw: message.raw ?? ''))));
                      } else {
                        return ListTile(title: Text('No data available'));
                      }
                    });
              }),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error : $error')),
      ),
    );
  }
}
