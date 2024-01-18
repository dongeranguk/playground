import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_user_schedule.dart';
import 'package:playground/screen/main/tab/calendar/w_user_schedule.dart';

final DateTime now = DateTime.now();

class ScheduleList extends StatefulWidget {
  final UserSchedule userSchedule;
  const ScheduleList({required this.userSchedule, super.key});

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {

  late UserSchedule _userSchedule;

  @override
  void initState() {
    _userSchedule = widget.userSchedule;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: UserScheduleList(days: getDays(), userSchedule: _userSchedule,)
        )
      ],
    );
  }
}

List<int> getDays() {
  List<int> days = [];
  int firstDay = DateTime(now.year, now.month, 1).day;
  int lastDay = DateTime(now.year, now.month+1, 0).day;

  for(var i=firstDay; i<=lastDay; i++) {
    days.add(i);
  }

  return days;
}

