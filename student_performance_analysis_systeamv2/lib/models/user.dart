import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String token;
  final String password;
  final String userType;
  final int age;
  final String bloodType;
  final String userClass;
  final String department;
  final String sex;

  User({
    this.id = '',
    required this.name,
    required this.email,
    this.token = '',
    required this.password,
    this.userType = '',
    this.age = 0,
    this.bloodType = '',
    this.userClass = '',
    this.department = '',
    this.sex = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'password': password,
      'userType': userType,
      'age': age,
      'bloodType': bloodType,
      'class': userClass,
      'department': department,
      'sex': sex,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      password: map['password'] ?? '',
      userType: map['userType'] ?? '',
      age: map['age']?.toInt() ?? 0,
      bloodType: map['bloodType'] ?? '',
      userClass: map['class'] ?? '',
      department: map['department'] ?? '',
      sex: map['sex'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
