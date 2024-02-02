import 'package:flutter/material.dart';
import 'package:playground/screen/main/tab/calendar/vo/calendar_type.dart';

class CalendarTypeMenu extends StatefulWidget {
  final CalendarType type;
  final Function(CalendarType) callback;

  const CalendarTypeMenu(
      {required this.type, required this.callback, super.key});

  @override
  State<CalendarTypeMenu> createState() => _CalendarTypeMenuState();
}

class _CalendarTypeMenuState extends State<CalendarTypeMenu> {
  late CalendarType _selectedMenu;

  @override
  void initState() {
    _selectedMenu = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      label: Text(_selectedMenu.type),
      dropdownMenuEntries: <DropdownMenuEntry<CalendarType>>[
        DropdownMenuEntry(
            value: CalendarType.every, label: CalendarType.every.type),
        DropdownMenuEntry(
            value: CalendarType.personal, label: CalendarType.personal.type),
      ],
      onSelected: (selectedMenu) {
        if (selectedMenu != null) {
          setState(() {
            _selectedMenu = selectedMenu;
            widget.callback.call(_selectedMenu);
            // shared_preference 라이브러리를 사용하여 사용자가 선택한 타입을 저장해보기.
          });
        }
      },
    );
  }
}
