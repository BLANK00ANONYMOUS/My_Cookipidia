import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String firstName;
  final String lastName;
  final String role;
  final String profileImageUrl;
  final int points;
  final bool darkMode;

  User({
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.profileImageUrl,
    required this.points,
    required this.darkMode,
  });

  // factory User.fromJson(Map<dynamic, dynamic> json) => User(
  //     text: json['text'] as String,
  //     date: DateTime.parse(json['date'] as String),
  //     email: json['email'] as String?);
  // Map<String, dynamic> toJson() => <String, dynamic>{
  //   'date': date.toString(),
  //   'text': text,
  //   'email': email,
  // };
  // factory Message.fromSnapshot(DocumentSnapshot snapshot) {
  //   final message = Message.fromJson(snapshot.data() as Map<String, dynamic>);
  //   message.reference = snapshot.reference;
  //   return message;
  // }
}
