import 'package:flutter/material.dart';

class HomeFragment extends StatefulWidget {
  final String tabName;

  const HomeFragment({required this.tabName, super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {

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
