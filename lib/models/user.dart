import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final int phone;
  final String emailAddress;
  final List<String> skills;
  final bool experience;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.emailAddress,
    required this.skills,
    required this.experience,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    emailAddress: json["email_address"],
    skills: List<String>.from(json["skills"].map((x) => x)),
    experience: json["experience"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email_address": emailAddress,
    "skills": List<dynamic>.from(skills.map((x) => x)),
    "experience": experience,
  };
}