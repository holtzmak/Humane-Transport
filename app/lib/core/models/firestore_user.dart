class FirestoreUser {
  final String firstName;
  final String lastName;
  final String userEmailAddress;
  final String userPhoneNumber;
  final String userId;
  final bool isAdmin;

  FirestoreUser(
      {this.firstName,
      this.lastName,
      this.userEmailAddress,
      this.userPhoneNumber,
      this.userId,
      this.isAdmin});
  FirestoreUser.fromJSON(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        userEmailAddress = json['userEmailAddress'],
        userPhoneNumber = json['userPhoneNumber'],
        userId = json['userId'],
        isAdmin = json['isAdmin'];

  Map<String, dynamic> toJSON() => {
        'firstName': firstName,
        'lastName': lastName,
        'userEmailAddress': userEmailAddress,
        'userPhoneNumber': userPhoneNumber,
        'userId': userId,
        'isAdmin': isAdmin,
      };

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      userEmailAddress.hashCode ^
      userPhoneNumber.hashCode ^
      isAdmin.hashCode ^
      userId.hashCode;

  @override
  bool operator ==(other) {
    return (other is FirestoreUser) &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.userEmailAddress == userEmailAddress &&
        other.userPhoneNumber == userPhoneNumber &&
        other.userId == userId &&
        other.isAdmin == isAdmin;
  }
}
