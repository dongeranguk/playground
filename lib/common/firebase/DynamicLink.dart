import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:playground/screen/main/s_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';

class DynamicLink {
  static late final SharedPreferences pref;

  static Future<bool> setUp() async {
    pref = await SharedPreferences.getInstance();
    bool isExistDynamicLink = await _getInitialDynamicLink();
    _addListener();

    return isExistDynamicLink;
  }

  static Future<bool> _getInitialDynamicLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    print('initialLink : ${initialLink}');
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      print('deepLink : ${deepLink}');

      navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => HomeScreen()));

      return true;
    }
    return false;
  }

  static void _addListener() {
    FirebaseDynamicLinks.instance.onLink.listen((pendingDynamicLinkData) async {
      if (pendingDynamicLinkData != null) {
        final Uri deepLink = pendingDynamicLinkData.link;

        String emailLink = deepLink.toString();

        if (FirebaseAuth.instance.isSignInWithEmailLink(emailLink)) {
          try {
            String? email = pref.getString('email');

            if (email != null) {
              final userCredential = await FirebaseAuth.instance
                  .signInWithEmailLink(email: email, emailLink: emailLink);

              final emailAddress = userCredential.user?.email;

              print('Successfully signed in with $emailAddress !');
            }
          } catch (error) {
            print('Error signing in with email link');
          }
        }
      }
    }).onError((error) => print('error : $error'));
  }
}
