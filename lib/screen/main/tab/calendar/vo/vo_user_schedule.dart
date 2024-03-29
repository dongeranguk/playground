class UserSchedule {
  final String name;
  final DateTime from;
  final DateTime to;
  final String title;
  String? memo;

  UserSchedule(
    this.memo, {
    required this.name,
    required this.from,
    required this.to,
    required this.title,
  });

  @override
  String toString() {
    return 'UserSchedule{name: $name, from: $from, to: $to, title: $title, memo: $memo}';
  }
}
