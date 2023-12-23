class SimpleMail {
  final int id;
  final String from;
  final String content;
  final DateTime createdAt;
  bool isRead;

  SimpleMail(this.id, this.from, this.content, this.createdAt, this.isRead);
}