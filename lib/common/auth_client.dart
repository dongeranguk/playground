
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

Future<http.Client> getAuthenticationHttpClient() async {
  final googleUser = await GoogleSignIn().signIn();

  if(googleUser == null) {
    throw Exception('사용자가 로그인하지 않았습니다.');
  }

  final googleAuth = await googleUser.authentication;
  final googleCredential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  await FirebaseAuth.instance.signInWithCredential(googleCredential);

  final scopes = [GmailApi.gmailReadonlyScope];

  var authenticatedClient = authenticatedClientFromAccessToken(googleAuth.accessToken!, scopes);

  return authenticatedClient;
}

http.Client authenticatedClientFromAccessToken(String accessToken, List<String> scopes) {
  var client = http.Client();
  var authHeaders = {
    'Authorization': 'Bearer $accessToken',
  };

  return authenticatedClient(client, AccessCredentials(AccessToken('Bearer', accessToken, DateTime.now().toUtc().add(const Duration(hours:1))), null, scopes));

}