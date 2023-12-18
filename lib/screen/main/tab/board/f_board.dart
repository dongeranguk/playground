import 'package:flutter/material.dart';

class BoardFragment extends StatefulWidget {
  final String tabName;

  const BoardFragment({required this.tabName, super.key});

  @override
  State<BoardFragment> createState() => _BoardFragmentState();
}

class _BoardFragmentState extends State<BoardFragment> {
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
