import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_user_schedule.dart';

class UserScheduleList extends StatefulWidget {
  final List<int> days;
  final UserSchedule userSchedule;

  //final List<UserSchedule> schedules;
  const UserScheduleList(
      {required this.days, required this.userSchedule, super.key});

  @override
  State<UserScheduleList> createState() => _UserScheduleListState();
}

class _UserScheduleListState extends State<UserScheduleList> {
  late UserSchedule _userSchedule;

  @override
  void initState() {
    _userSchedule = widget.userSchedule;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            alignment: Alignment.topCenter,
            child: Text(_userSchedule.name),
          ),
          ...widget.days.map(
            (e) => Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid, color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Stack(
                      children: [
                        Text(e.toString()),
                        Positioned(
                          top: 20,
                          child: e >= _userSchedule.from.day && e <= _userSchedule.to.day ? Line(
                            title: _userSchedule.title,
                            from: _userSchedule.from.day,
                            to: _userSchedule.to.day, // enum 타입으로 스케줄에 지정된 날짜가 기간에 속하는지 표현하자.
                          ) : SizedBox(),
                        )
                      ],
                    ))),
          )
        ],
      ),
    );
  }
}

class Line extends StatelessWidget {
  const Line({
    super.key,
    this.title,
    required this.from,
    required this.to,
    this.width = 100,
    this.height = 20,
    this.color,
  });

  final String? title;
  final double width;
  final double height;
  final Color? color;
  final int from;
  final int to;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color ?? Colors.lightBlueAccent,
      child: title != null
          ? Align(
              alignment: Alignment.topLeft,
              child: Text(
                title!,
                style: TextStyle(fontSize: 15),
              ))
          : null,
    );
  }
}
