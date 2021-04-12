import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as auth;


class User {
  String email = '';
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  bool active = false;
  String userID;
  String profilePictureURL = '';
  bool selected = false;

  User(
      {this.email,
        this.firstName,
        this.phoneNumber,
        this.lastName,
        this.active,
        this.userID,
        this.profilePictureURL});

  String fullName() {
    return '$firstName $lastName';
  }

  factory User.fromFB(auth.User user_import) {
    return new User(
        email: user_import.email,
        active: true,
        userID: user_import.uid,

        firstName: 'Dr Charles',
        lastName: 'Dr Charles',
        phoneNumber: '.',
        profilePictureURL: '.');
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',
        active: parsedJson['active'] ?? false,
        phoneNumber: parsedJson['phoneNumber'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'phoneNumber': this.phoneNumber,
      'id': this.userID,
      'active': this.active,
      'profilePictureURL': this.profilePictureURL,
    };
  }
}