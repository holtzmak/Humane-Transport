import 'package:flutter/material.dart';

class UserInformation {
  final String userId;
  final String firstName;
  final String lastName;
  final String userEmailAddress;
  final String userPhoneNumber;

  UserInformation({
    @required this.userId,
    @required this.firstName,
    @required this.lastName,
    @required this.userEmailAddress,
    @required this.userPhoneNumber,
  });

  UserInformation.fromFirestore(Map<String, dynamic> data)
      : userId = data['userId'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        userEmailAddress = data['userEmailAddress'],
        userPhoneNumber = data['userPhoneNumber'];

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'userEmailAddress': userEmailAddress,
      'userPhoneNumber': userPhoneNumber,
    };
  }
}
