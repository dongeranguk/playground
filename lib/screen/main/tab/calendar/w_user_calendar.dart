import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class UserCalendar extends StatefulWidget {
  const UserCalendar({super.key});

  @override
  State<UserCalendar> createState() => _UserCalendarState();
}

class _UserCalendarState extends State<UserCalendar> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  DateTime? _selectedDay;
  late CalendarFormat _format;

  @override
  void initState() {
    _focusedDay = DateTime.now();
    _firstDay = _focusedDay.subtract(const Duration(days: 5 * 365));
    _lastDay = _focusedDay.add(const Duration(days: 5 * 365));
    _selectedDay ?? _focusedDay;
    _format = CalendarFormat.month;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(Icons.arrow_back_ios),
              Text('yyyy 년 MM월'),
              TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(2010, 1, 1),
                lastDay: DateTime(2030, 1, 1),
                locale: 'ko',
                calendarFormat: _format,
                onDaySelected: (selectedDay, focusedDay) {
                  if (selectedDay != null) {
                    _selectedDay = selectedDay;
                  }
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onFormatChanged: (CalendarFormat format) => setState(() {
                  _format = format;
                }),
              ),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Container(
                        color: Colors.red,
                        height: 50,
                        width: 50,
                        child: Text('김동욱')),
                    Expanded(
                      child: TableCalendar(
                        focusedDay: _focusedDay,
                        firstDay: DateTime(2010, 1, 1),
                        lastDay: DateTime(2030, 1, 1),
                        locale: 'ko',
                        calendarFormat: CalendarFormat.week,
                        onDaySelected: (selectedDay, focusedDay) {
                          if (selectedDay != null) {
                            _selectedDay = selectedDay;
                          }
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        headerStyle: HeaderStyle(formatButtonVisible: false),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
