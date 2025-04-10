class UserData {
  final String name;
  final String email;
  final DateTime dateOfBirth;
  final double weight;
  final double height;
  final List<String> healthConditions;
  final String gender;

  UserData({
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.weight,
    required this.height,
    required this.healthConditions,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'weight': weight,
      'height': height,
      'healthConditions': healthConditions,
      'gender': gender,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'] as String,
      email: json['email'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      weight: json['weight'] as double,
      height: json['height'] as double,
      healthConditions: (json['healthConditions'] as List<dynamic>).map((e) => e as String).toList(),
      gender: json['gender'] as String,
    );
  }
}
