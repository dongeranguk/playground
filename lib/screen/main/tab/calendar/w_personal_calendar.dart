import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PersonalCalendar extends StatefulWidget {
  const PersonalCalendar({
    super.key,
    required DateTime focusedDay,
    required DateTime firstDay,
    required DateTime lastDay,
  }) : _focusedDay = focusedDay, _firstDay = firstDay, _lastDay = lastDay;

  final DateTime _focusedDay;
  final DateTime _firstDay;
  final DateTime _lastDay;

  @override
  State<PersonalCalendar> createState() => _PersonalCalendarState();
}

class _PersonalCalendarState extends State<PersonalCalendar> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: widget._focusedDay,
      firstDay: widget._firstDay,
      lastDay: widget._lastDay,
      locale: 'ko',
    );
  }
}