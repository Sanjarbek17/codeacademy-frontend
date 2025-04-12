class Teacher {
  final int id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phone;
  final String? gitHub;
  final String? codewars;
  final String? tgUsername;
  final String dateCreated;
  final String dateUpdated;
  final int type;

  Teacher({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phone,
    this.gitHub,
    this.codewars,
    this.tgUsername,
    required this.dateCreated,
    required this.dateUpdated,
    required this.type,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      gitHub: json['github'] as String?,
      codewars: json['codewars'] as String?,
      tgUsername: json['tg_username'] as String?,
      dateCreated: json['date_created'] as String,
      dateUpdated: json['date_updated'] as String,
      type: json['type'] as int,
    );
  }
}
