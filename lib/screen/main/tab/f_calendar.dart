import 'package:flutter/material.dart';

class CalendarFragment extends StatefulWidget {
  final String tabName;

  const CalendarFragment({required this.tabName, super.key});

  @override
  State<CalendarFragment> createState() => _CalendarFragmentState();
}

class _CalendarFragmentState extends State<CalendarFragment> {
  late String _tabName;

  @override
  void initState() {
    _tabName = widget.tabName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _tabName,
        style: const TextStyle(fontSize: 50),
      ),
    );
  }
}
