import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_user_schedule.dart';
import 'package:playground/screen/main/tab/calendar/w_user_schedule.dart';
import 'package:table_calendar/table_calendar.dart';

final DateTime now = DateTime.now();

class PublicCalendar extends StatefulWidget {
  final UserSchedule userSchedule;
  final DateTime currentDay;
  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;

  const PublicCalendar({
    required this.userSchedule,
    required this.currentDay,
    required this.focusedDay,
    required this.firstDay,
    required this.lastDay,
    super.key,
  });

  @override
  State<PublicCalendar> createState() => _PublicCalendarState();
}

class _PublicCalendarState extends State<PublicCalendar> {
  late UserSchedule _userSchedule;
  late DateTime _currentDay;
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;

  @override
  void initState() {
    _userSchedule = widget.userSchedule;

    _currentDay = widget.currentDay;
    _focusedDay = widget.focusedDay;
    _firstDay = widget.firstDay;
    _lastDay = widget.lastDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: Colors.grey.shade50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(_userSchedule.name),
                Expanded(
                  child: TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: _firstDay,
                    lastDay: _lastDay,
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                    ),
                    calendarFormat: CalendarFormat.week,
                    locale: 'ko',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
    // return Column(
    //   children: [
    //     SingleChildScrollView(
    //       scrollDirection: Axis.horizontal,
    //       child:
    //       // UserScheduleList(days: getDays(), userSchedule: _userSchedule,)
    //     )
    //   ],
    // );
  }
}

List<int> getDays() {
  List<int> days = [];
  int firstDay = DateTime(now.year, now.month, 1).day;
  int lastDay = DateTime(now.year, now.month + 1, 0).day;

  for (var i = firstDay; i <= lastDay; i++) {
    days.add(i);
  }

  return days;
}
