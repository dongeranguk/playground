class Mail {
  final int id;
  final String title;
  final String content;
  final String from;
  final String to;
  final DateTime createdAt;
  DateTime? updatedAt;

  Mail(
    this.id,
    this.title,
    this.content,
    this.from,
    this.to,
    this.createdAt,
    this.updatedAt,
  );
}
