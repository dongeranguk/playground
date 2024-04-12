import 'package:flutter/material.dart';
import 'package:playground/screen/main/s_home.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class WiseApp extends StatefulWidget {
  const WiseApp({super.key});

  @override
  State<WiseApp> createState() => _WiseAppState();
}

class _WiseAppState extends State<WiseApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
      navigatorKey: navigatorKey,
      home: const HomeScreen(),
    );
  }
}
