class Student {
  final int? id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String tgUsername;
  String? startDate;
  String? endDate;

  Student({
    this.id,
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.phone,
    required this.tgUsername,
    this.startDate,
    this.endDate,
  });

  factory Student.getStudent(Map data) {
    return Student(
      id: data['id'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      email: data['email'],
      phone: data['phone'],
      tgUsername: data['tg_username'],
      startDate: data['date_created'],
      endDate: data['date_updated'],
    );
  }
  Student mapToStudent(Map data) {
    return Student(
      firstName: data['first_name'],
      email: data['email'],
      lastName: data['last_name'],
      phone: data['phone'],
      tgUsername: data['tg_username'],
    );
  }
}
