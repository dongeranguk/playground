import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:playground/common/data/preference/PreferenceItem.dart';
import 'package:playground/common/data/preference/appPreferences.riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';

import '../../s_home.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with AfterLayoutMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/gmail.readonly']);

  UserCredential? userCredential;
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    FlutterNativeSplash.remove();
    userCredential = await signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    final pref = ref.watch(appPreferencesProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/splash/splash.png',
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
              GestureDetector(
                  onTap: () async {
                    if (firebaseAuth.currentUser != null) {
                      String? token =
                          await firebaseAuth.currentUser!.getIdToken();
                      print(token);
                    }
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
                      child: const Text('토큰 가져오기',
                          style: TextStyle(color: Colors.black, fontSize: 20)))),
              GestureDetector(
                  onTap: () async {
                      UserCredential? usercredential = await signInWithGoogle();
                      if(usercredential != null) {
                        print('usercredential.user?.providerData : ${usercredential.user?.providerData}');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                      }
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
                      child: const Text('구글 로그인',
                          style: TextStyle(color: Colors.black, fontSize: 20)))),
        
              GestureDetector(
                  onTap: () async {
                      logout();
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
                      child: const Text('로그아웃',
                          style: TextStyle(color: Colors.black, fontSize: 20)))),
            ],
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('로그인 정보가 잘못되었어요.')));
      print('code : ${e.code} message : ${e.message}');
    }
  }

  Future<void> sendLinkToEmail(String email) async {
    var acs = ActionCodeSettings(
        url: 'https://ninth-physics-420514.firebaseapp.com',
        handleCodeInApp: true,
        androidPackageName: 'com.example.playground',
        iOSBundleId: 'com.example.playground');

    print('email : ${email}');
    return firebaseAuth
        .sendSignInLinkToEmail(email: email, actionCodeSettings: acs)
        .catchError(
            (onError) => print('Error sending email verification $onError'))
        .then((value) {
      print('Successfully sent email verification');
      ref
          .read(appPreferencesProvider.notifier)
          .setPref(PreferenceItem('email', email));
    });
  }

  Future<void> logout() async {
    return await firebaseAuth.signOut().whenComplete(() {
      _googleSignIn.signOut(); // 구글 로그아웃까지 했어야 이전 로그인 정보로 사용하지 않고, 계정 선택창이 팝업된다.
      // TODO : 만약, 해당 함수에서 구글 로그아웃할 때 오류가 발생하면, 아래 catchError 가 error를 잡는지 확인해보자.
    }).catchError((onError) => print('Error signOut : ${onError}')).then((value) {
      print('Successfully signOut');
    });
  }

  Future<UserCredential?> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if(googleUser == null) return null;

    final authHeaders = await googleUser.authHeaders;
    print('authHeaders : ${authHeaders}');

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    var result = await firebaseAuth.signInWithCredential(credential);

    if(result != null) {
      return result;
    }
    print('firebaseAuth.currentUser.providerData : ${firebaseAuth.currentUser?.providerData}');
    return null;
  }
}
