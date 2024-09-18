import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:playground/screen/main/login/screen/s_login.dart';
import 'package:playground/screen/main/tab/home/f_home.dart';
import 'package:playground/screen/main/tab/mail/f_mail.dart';
import 'package:playground/screen/main/tab/tab_items.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin {
  late int _currentIndex;
  late String _tabName;

  final tabs = [
    TabItem.home,
    TabItem.mail,
    TabItem.board,
    TabItem.calendar,
    TabItem.login,
  ];

  final List<Widget> _pages = [
    TabItem.home.page,
    TabItem.mail.page,
    TabItem.board.page,
    TabItem.calendar.page,
    TabItem.login.page,
  ];

  @override
  void initState() {
    _currentIndex = 0;
    _tabName = tabs[_currentIndex].tabName;
    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tabName)),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: tabs
            .map((tab) => tab.toNavigationBarItem(context, isActivated: true))
            .toList(),
        onTap: (newIndex) => setState(() {
          if (_currentIndex != newIndex) {
            _currentIndex = newIndex;
            _tabName = tabs[_currentIndex].tabName;
          }
        }),
        currentIndex: _currentIndex,
      ),
    );
  }
}
