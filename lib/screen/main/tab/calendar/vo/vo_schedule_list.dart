import 'package:playground/screen/main/tab/calendar/vo/vo_user_schedule.dart';

final scheduleList = [
  UserSchedule('오늘 해야하는 일이다.', name: '김동욱', from: DateTime.now(), to: DateTime.now().add(Duration(days: 1)), title: '오늘 할 일1'),
  UserSchedule('오늘 해야하는 일이다.', name: '김동욱', from: DateTime.now(), to: DateTime.now().add(Duration(days: 2)), title: '오늘 할 일1'),
  UserSchedule('오늘 해야하는 일이다.', name: '김동욱', from: DateTime.now(), to: DateTime.now().add(Duration(days: 3)), title: '오늘 할 일1'),
  UserSchedule('오늘 해야하는 일이다.', name: '김동욱', from: DateTime.now(), to: DateTime.now().add(Duration(days: 4)), title: '오늘 할 일1'),
  UserSchedule('내일 해야하는 일이다.', name: '홍길동', from: DateTime.now().add(Duration(days:1)), to: DateTime.now().add(Duration(days: 5)), title: '내일 할 일1'),
  UserSchedule('내일 해야하는 일이다.', name: '홍길동', from: DateTime.now().add(Duration(days:1)), to: DateTime.now().add(Duration(days: 6)), title: '내일 할 일1'),
  UserSchedule('내일 해야하는 일이다.', name: '홍길동', from: DateTime.now().add(Duration(days:1)), to: DateTime.now().add(Duration(days: 7)), title: '내일 할 일1'),
];