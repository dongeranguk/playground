import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_schedule_list.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_user_schedule.dart';
import 'package:playground/screen/main/tab/calendar/w_personal_calendar.dart';
import 'package:playground/screen/main/tab/calendar/w_public_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'vo/calendar_type.dart';
import 'w_calendar_type_menu.dart';

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
  late DateTime _firstDay;
  late DateTime _lastDay;

  @override
  void initState() {
    _type = CalendarType.every;
    _firstDay = _currentDay
        .subtract(Duration(days: ((_currentDay.year * 5) / 365).round()));
    _lastDay =
        _currentDay.add(Duration(days: ((_currentDay.year * 5) / 365).round()));
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
                                  firstDay: _firstDay,
                                  lastDay: _lastDay,
                                ))
                            .toList())
                    : PersonalCalendar(
                        userSchedule: scheduleList
                            .where((element) => element.name == '김동욱')
                            .toList(),
                        currentDay: _currentDay,
                        firstDay: _firstDay,
                        lastDay: _lastDay,
                        callback: selectedDay)
              ],
            ),
          ),
        ),
        floatingActionButton: CalendarFAB(from: _selectedDay));
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
    _selectedDay = selectedDay;
  }
}

class CalendarFAB extends StatefulWidget {
  final DateTime from;
  DateTime? to;

  CalendarFAB({
    required this.from,
    super.key,
  });

  @override
  State<CalendarFAB> createState() => _CalendarFABState();
}

class _CalendarFABState extends State<CalendarFAB> {
  late DateTime _from;

  @override
  void initState() {
    _from = widget.from;
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
                      Text('선택한 날짜 : ${_from}'),
                    ])
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
