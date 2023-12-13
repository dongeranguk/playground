import 'package:flutter/material.dart';

class MailFragment extends StatefulWidget {
  final String tabName;

  const MailFragment({required this.tabName, super.key});

  @override
  State<MailFragment> createState() => _MailFragmentState();
}

class _MailFragmentState extends State<MailFragment> {
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
    );;
  }
}
