import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/board/f_board.dart';
import 'package:playground/screen/main/tab/mail/f_mail.dart';

import 'calendar/f_calendar.dart';
import 'home/f_home.dart';

enum TabItem {
  home(Icons.home, '홈', HomeFragment(tabName: '홈')),
  mail(Icons.mail, '메일', MailFragment(tabName: '메일')),
  board(Icons.developer_board, '게시판', BoardFragment(tabName: '게시판')),
  calendar(Icons.calendar_month, '캘린더', CalendarFragment(tabName: '캘린더'));

  final IconData activeIcon;
  final IconData inActiveIcon;
  final String tabName;
  final Widget page;

  const TabItem(this.activeIcon, this.tabName, this.page,
      {IconData? inActiveIcon})
      : inActiveIcon = inActiveIcon ?? activeIcon;

  BottomNavigationBarItem toNavigationBarItem(BuildContext context,
      {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(tabName),
          // isActivated ? activeIcon : inActiveIcon,
          activeIcon,
        ),
        label: tabName);
  }
}
