import 'package:flutter/material.dart';

enum CalendarType {
  personal('개인'),
  every('모두');

  final String type;
  final Widget? calendarType;

  const CalendarType(this.type, {this.calendarType});
}
