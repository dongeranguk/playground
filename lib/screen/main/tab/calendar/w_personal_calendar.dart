import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_user_schedule.dart';
import 'package:table_calendar/table_calendar.dart';

class PersonalCalendar extends StatefulWidget {
  const PersonalCalendar({
    super.key,
    required this.userSchedule,
    required this.focusedDay,
    required this.firstDay,
    required this.lastDay,
  });

  final UserSchedule userSchedule;
  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;

  @override
  State<PersonalCalendar> createState() => _PersonalCalendarState();
}

class _PersonalCalendarState extends State<PersonalCalendar> {

  late UserSchedule _userSchedule;
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;

  @override
  void initState() {
    _userSchedule = widget.userSchedule;
    _focusedDay = widget.focusedDay;
    _firstDay = widget.firstDay;
    _lastDay = widget.lastDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: _firstDay,
      lastDay: _lastDay,
      locale: 'ko',
    );
  }
}
