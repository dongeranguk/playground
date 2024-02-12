import 'package:flutter/material.dart';
import 'package:playground/common/dart/extension/date_extension.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_schedule_list.dart';
import 'package:playground/screen/main/tab/calendar/w_personal_calendar.dart';
import 'package:playground/screen/main/tab/calendar/w_public_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'vo/calendar_type.dart';
import 'w_calendar_type_menu.dart';

final DateTime now = DateTime.now();
final DateTime firstDay = now.subtract(Duration(days: (5 * 365).round()));
final DateTime lastDay = now.add(Duration(days: (5 * 365).round()));

class CalendarFragment extends StatefulWidget {
  final String tabName;

  const CalendarFragment({required this.tabName, super.key});

  @override
  State<CalendarFragment> createState() => _CalendarFragmentState();
}

class _CalendarFragmentState extends State<CalendarFragment> {
  late CalendarType _type;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _controller = TextEditingController();
  late String keyword = '';

  final DateTime _currentDay = DateTime.now();
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    _type = CalendarType.every;
    _selectedDay = _currentDay;
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
            CalendarFAB(now: DateTime.now(), from: _selectedDay));
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
    });
  }

  void selectedRange(DateTime from, DateTime to) {
    setState(() {});
  }
}

class CalendarFAB extends StatefulWidget {
  CalendarFAB({
    required DateTime now,
    required DateTime from,
    super.key,
  })  : _now = now,
        _from = DateTime(from.year, from.month, from.day, now.hour),
        _to = from.add(Duration(days: 1, hours: now.hour + 1));

  final DateTime _now;
  DateTime _from;
  final DateTime _to;

  @override
  State<CalendarFAB> createState() => _CalendarFABState();
}

class _CalendarFABState extends State<CalendarFAB> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: const Text('취소', style: TextStyle(fontSize: 17)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text('새로운 이벤트',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                      TextButton(
                        child: const Text(
                          '추가',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {},
                      ),
                    ]),
                SizedBox(height: 15),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: '제목', border: InputBorder.none),
                            style: TextStyle(fontSize: 15),
                            controller: _textEditingController,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 30),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              Text('시작'),
                              const Spacer(),
                              GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.shade200),
                                    child: Text(
                                      widget._from.formattedDotYMD,
                                    )),
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: widget._from,
                                      firstDate: firstDay,
                                      lastDate: lastDay);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.shade200),
                                    child: Text(
                                      widget._from.formattedHm,
                                    )),
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: widget._from,
                                      firstDate: firstDay,
                                      lastDate: lastDay);
                                },
                              ),
                            ],
                          ),
                        ),
                        Line(),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              Text('종료'),
                              const Spacer(),
                              GestureDetector(
                                child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.shade200),
                                    child: Text(
                                      widget._to.formattedDotYMD,
                                    )),
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: widget._to,
                                      firstDate: firstDay,
                                      lastDate: lastDay);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.shade200),
                                    child: Text(
                                      widget._to.formattedHm,
                                    )),
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: widget._to,
                                      firstDate: firstDay,
                                      lastDate: lastDay);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          isScrollControlled: true,
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class Line extends StatelessWidget {
  Line({
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
