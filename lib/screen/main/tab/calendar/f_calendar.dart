import 'dart:async';
import 'dart:ffi';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/common/dart/extension/date_extension.dart';
import 'package:playground/screen/main/tab/calendar/fab/w_floating_calendar_button.riverpod.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_schedule_list.dart';
import 'package:playground/screen/main/tab/calendar/w_personal_calendar.dart';
import 'package:playground/screen/main/tab/calendar/w_public_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fab/w_floating_calendar_button.dart';
import 'vo/calendar_type.dart';
import 'w_calendar_type_menu.dart';

final DateTime now = DateTime.now();
final DateTime firstDay = now.subtract(Duration(days: (5 * 365).round()));
final DateTime lastDay = now.add(Duration(days: (5 * 365).round()));

class CalendarFragment extends ConsumerStatefulWidget {
  final String tabName;

  const CalendarFragment({required this.tabName, super.key});

  @override
  ConsumerState<CalendarFragment> createState() => _CalendarFragmentState();
}

class _CalendarFragmentState extends ConsumerState<CalendarFragment> {
  late CalendarType _type;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _controller = TextEditingController();
  late String keyword = '';

  final DateTime _currentDay = DateTime.now();
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late DateTime _to;

  @override
  void initState() {
    _type = CalendarType.every;
    _to = _currentDay.add(const Duration(days: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            child: Row(
              children: [
                CalendarTypeMenu(
                  type: _type,
                  callback: selectType,
                ),
                const Spacer(),
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(suffixIcon: Icon(Icons.search)),
                    onChanged: (value) => setState(() {
                      if (value != null) keyword = value;
                    }),
                    textInputAction: TextInputAction.go,
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                _type == CalendarType.every
                    ? Column(
                        children: scheduleList
                            .where((e) => e.name.contains(keyword))
                            .map((e) => PublicCalendar(
                                  userSchedule: e,
                                  currentDay: _currentDay,
                                  firstDay: firstDay,
                                  lastDay: lastDay,
                                ))
                            .toList())
                    : PersonalCalendar(
                        userSchedule: scheduleList
                            .where((element) => element.name == '김동욱')
                            .toList(),
                        currentDay: _currentDay,
                        firstDay: firstDay,
                        lastDay: lastDay,
                        callback: selectedDay),
              ],
            ),
          ),
        ),
        floatingActionButton:
            const CalendarFAB());
  }

  void selectType(CalendarType type) {
    setState(() {
      if (_type != type) {
        switch (type) {
          case CalendarType.every:
            _type = CalendarType.every;
            break;
          case CalendarType.personal:
            _type = CalendarType.personal;
            break;
        }
      }
    });
  }

  void selectedDay(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
      ref.read(floatingButtonSelectedDayProvider.notifier).state = _selectedDay;
    });
  }


  void selectedRange(DateTime from, DateTime to) {
    setState(() {});
  }
}



class Line extends StatelessWidget {
  const Line({
    super.key,
  })  : _height = 1,
        _width = double.infinity;

  final double? _height;
  final double? _width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      height: _height,
      child: Container(
        color: Colors.grey.shade400,
      ),
    );
  }
}
