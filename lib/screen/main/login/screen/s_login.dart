import 'dart:async';
import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/app.dart';
import 'package:playground/common/data/preference/PreferenceItem.dart';
import 'package:playground/common/data/preference/appPreferences.riverpod.dart';
import 'package:playground/screen/main/login/screen/s_signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({required this.fireBaseAuth, super.key});

  final FirebaseAuth fireBaseAuth;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with AfterLayoutMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FirebaseAuth firebaseAuth;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    firebaseAuth = widget.fireBaseAuth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pref = ref.watch(appPreferencesProvider);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash/splash.png',
              width: 300,
              height: 200,
              alignment: Alignment.topCenter,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '아이디를 입력해주세요.';
                      }
                      return null;
                    },
                    controller: emailController,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호를 입력해주세요.';
                      }
                      return null;
                    },
                    controller: passwordController,
                  ),
                ],
              ),
            ),
            GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    signIn(emailController.text, passwordController.text);
                  }
                },
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade500,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Text('로그인',
                        style: TextStyle(color: Colors.white, fontSize: 20)))),
            GestureDetector(
                onTap: () {
                  sendLinkToEmail(emailController.text);
                },
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)),
                    child: const Text('인증 요청',
                        style: TextStyle(color: Colors.black, fontSize: 20)))),
          ],
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(content: Text('로그인 정보가 잘못되었어요.')));
      print('code : ${e.code} message : ${e.message}');
    }
  }

  Future<void> sendLinkToEmail(String email) async {

    var acs = ActionCodeSettings(
        url: 'https://ninth-physics-420514.firebaseapp.com',
        handleCodeInApp: true,
        androidPackageName: 'com.example.playground',
        iOSBundleId: 'com.example.playground');

    return firebaseAuth
        .sendSignInLinkToEmail(email: email, actionCodeSettings: acs)
        .catchError(
            (onError) => print('Error sending email verification $onError'))
        .then((value) {
          print('Successfully sent email verification');
          ref.read(appPreferencesProvider.notifier).setPref(PreferenceItem('email', email));
    });
  }

  Future<void> logout() async {
    return await firebaseAuth
        .signOut()
        .catchError((onError) => print('Error signOut'))
        .then((value) {
      print('Successfully signOut');
    });
  }
}
