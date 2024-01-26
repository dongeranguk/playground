import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_schedule_list.dart';
import 'package:playground/screen/main/tab/calendar/w_schedule_list.dart';

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

  @override
  void initState() {
    _type = CalendarType.every;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CalendarTypeMenu(
                type: _type,
                callback: selectType,
              ),
              const Spacer(),
              SizedBox(
                width: 200,
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Column(
                  children: _type == CalendarType.every
                      ? scheduleList
                          .where((e) => e.name.contains(keyword))
                          .map((e) => ScheduleList(userSchedule: e))
                          .toList()
                      : scheduleList
                          .where((e) => e.name.contains(keyword))
                          .map((e) => ScheduleList(userSchedule: e))
                          .toList()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
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
                            child: const Text('취소',
                                style: TextStyle(fontSize: 17)),
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
                          )
                        ])
                  ],
                ),
              ),
              isScrollControlled: true,
            );
          },
          child: const Icon(Icons.add),
        ));
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
}
