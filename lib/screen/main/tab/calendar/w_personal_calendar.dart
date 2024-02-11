import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_user_schedule.dart';
import 'package:table_calendar/table_calendar.dart';

class PersonalCalendar extends StatefulWidget {
  const PersonalCalendar({
    super.key,
    required this.userSchedule,
    required this.currentDay,
    required this.firstDay,
    required this.lastDay,
    required this.callback,
  });

  final List<UserSchedule> userSchedule;
  final DateTime currentDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final void Function(DateTime) callback;

  @override
  State<PersonalCalendar> createState() => _PersonalCalendarState();
}

class _PersonalCalendarState extends State<PersonalCalendar> {
  late List<UserSchedule> _userSchedule;
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  DateTime? _selectedDay;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    _userSchedule = widget.userSchedule;
    _focusedDay = widget.currentDay;
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
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      rangeSelectionMode: _rangeSelectionMode,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _rangeStart = null;
            _rangeEnd = null;
            _rangeSelectionMode = RangeSelectionMode.toggledOff;
          });
          widget.callback.call(_selectedDay!);
        }
      },
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          _selectedDay = null;
          _rangeStart = start;
          _rangeEnd = end;
          _rangeSelectionMode = RangeSelectionMode.toggledOn;
        });
      },
    );
  }
}
