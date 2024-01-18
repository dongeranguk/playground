import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_schedule_list.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_schedule_list.dart';
import 'package:playground/screen/main/tab/calendar/w_schedule_list.dart';

class CalendarFragment extends StatefulWidget {
  final String tabName;

  const CalendarFragment({required this.tabName, super.key});

  @override
  State<CalendarFragment> createState() => _CalendarFragmentState();
}

class _CalendarFragmentState extends State<CalendarFragment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: scheduleList.map((e) => ScheduleList(userSchedule: e)).toList()
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
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600)),
                                TextButton(
                                  child: const Text(
                                    '추가',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
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
}
