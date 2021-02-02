class User {
  String username;
  String password;

  User({this.username, this.password});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'username': username,
      'password': password,
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    username = map['username'];
    password = map['password'];
  }
}
