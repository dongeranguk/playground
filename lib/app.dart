import 'package:flutter/material.dart';

import 'main/s_home.dart';

class WiseApp extends StatefulWidget {
  const WiseApp({super.key});

  @override
  State<WiseApp> createState() => _WiseAppState();
}

class _WiseAppState extends State<WiseApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
