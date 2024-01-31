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
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        print(_selectedDay);
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
                                  child: Column(
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              child: const Text('취소',
                                                  style:
                                                      TextStyle(fontSize: 17)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const Text('새로운 이벤트',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            TextButton(
                                              child: const Text(
                                                '추가',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ]),
                                      Container(width: 300, height: 100, child: TextField()),
                                      TextField(),
                                    ],
                                  ),
                                ));
                      },
                      icon: Icon(Icons.add)),
                ],
              ),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 50,
                      height: 50,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text('김동욱',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
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
                        headerStyle: const HeaderStyle(
                            formatButtonVisible: false, titleCentered: true),
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
