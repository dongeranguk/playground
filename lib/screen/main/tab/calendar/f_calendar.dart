import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/calendar/vo/vo_schedule_list.dart';
import 'package:playground/screen/main/tab/calendar/w_schedule_list.dart';

class CalendarFragment extends StatefulWidget {
  final String tabName;

  const CalendarFragment({required this.tabName, super.key});

  @override
  State<CalendarFragment> createState() => _CalendarFragmentState();
}

class _CalendarFragmentState extends State<CalendarFragment> {
  final CalendarType _type = CalendarType.every;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _type == CalendarType.every
        ? Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              CalendarTypeMenu(
                type: _type,
                callback: selectType,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Column(
                  children: scheduleList
                      .map((e) => ScheduleList(userSchedule: e))
                      .toList()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) =>
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.9,
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
        ))
        : SizedBox();
  }

  void selectType() {
    setState(() {});
  }
}

enum CalendarType {
  personal('개인'),
  every('모두');

  final String type;
  final Widget? calendarType;

  const CalendarType(this.type, {this.calendarType});
}


//
// class CalendarTypeMenu extends StatefulWidget {
//   final CalendarType type;
//
//   const CalendarTypeMenu({required this.type, super.key});
//
//   @override
//   State<CalendarTypeMenu> createState() => _CalendarTypeMenuState();
// }
//
// class _CalendarTypeMenuState extends State<CalendarTypeMenu> {
//   late CalendarType _selectedMenu;
//
//   @override
//   void initState() {
//     _selectedMenu = widget.type;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownMenu(
//       label: Text(_selectedMenu.type),
//       menuStyle: MenuStyle(),
//       dropdownMenuEntries: <DropdownMenuEntry<CalendarType>>[
//         DropdownMenuEntry(
//             value: CalendarType.every, label: CalendarType.every.type),
//         DropdownMenuEntry(
//             value: CalendarType.personal, label: CalendarType.personal.type),
//         // DropdownMenuEntry(value: SampleItem.itemOne, label: '개인'),
//       ],
//       onSelected: (selectedMenu) {
//         if (selectedMenu != null) {
//           setState(() {
//             _selectedMenu = selectedMenu;
//           });
//         }
//       },
//     );
//   }
// }
