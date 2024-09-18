import 'package:googleapis/gmail/v1.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common/auth_client.dart';

part 'f_mail.riverpod.g.dart';

@riverpod
class UserMails extends _$UserMails{

  late GmailApi gmailApi;
  String? nextPageToken;

  @override
  FutureOr<List<Message>> build() async {
    final authenticatedClient = await getAuthenticationHttpClient();
    gmailApi = GmailApi(authenticatedClient);

    return await _fetchUserMail();

  }

  Future<void> fetchNextPage() async {
    if (nextPageToken == null) return;

    var result = await gmailApi.users.messages.list('me', maxResults: 20, pageToken: nextPageToken);
    state = AsyncData([...state.value!, ...result.messages!]);
    nextPageToken = result.nextPageToken;
  }

  Future<List<Message>> _fetchUserMail() async {

    var result = await gmailApi.users.messages.list('me', maxResults: 20, pageToken: nextPageToken);
    nextPageToken = result.nextPageToken;

    return result.messages!;

  }

  Future<Message> fetchMessageDetail(String messageId) async {
    try {

      Message message = await gmailApi.users.messages.get('me', messageId);

      return message;

    }catch(e) {
      throw Exception('Failed to load message detail');
    }
  }
}
