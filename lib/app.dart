import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/screen/main/login/screen/s_login.dart';
import 'package:playground/screen/main/s_home.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class WiseApp extends StatefulWidget {
  const WiseApp({super.key});

  @override
  State<WiseApp> createState() => _WiseAppState();
}

class _WiseAppState extends State<WiseApp> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    auth.authStateChanges().listen((User? user) {
      if(user != null) {
        this.user = user;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
      navigatorKey: navigatorKey,
      home: user != null ? const HomeScreen() : LoginScreen(fireBaseAuth: auth),
      routes: {
        '/signInWithEmail' : (context) => HomeScreen()
      },
    );
  }

}
