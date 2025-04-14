class Lesson {
  final int id;
  final String name;
  final String? description;
  final String? fileUrl;

  Lesson({
    required this.id,
    required this.name,
    this.description,
    this.fileUrl,
  });

  factory Lesson.getLesson(Map data) {
    return Lesson(
      id: data['id'],
      name: data['name'],
      description: data['description'], // Include description if available
      fileUrl: data['file'], // Include file URL if available
    );
  }
}
