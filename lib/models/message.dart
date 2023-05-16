class Message {
  String title;
  String body;
  String date;
  String? image;
  bool isNew;
  Message({
    required this.title,
    required this.body,
    required this.date,
    this.image,
    this.isNew = false,
  });
}
