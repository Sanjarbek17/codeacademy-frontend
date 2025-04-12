class Lesson {
  final int id;
  final String name;
  final String? description;

  Lesson({
    required this.id,
    required this.name,
    this.description,
  });

  factory Lesson.getLesson(Map data) {
    return Lesson(
      id: data['id'],
      name: data['name'],
      description: data['description'], // Include description if available
    );
  }
}
