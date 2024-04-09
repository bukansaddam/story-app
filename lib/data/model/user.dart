import 'dart:convert';

class User {
  String? name;
  String? token;

  User({this.name, this.token});

  String get getName => name ?? '';
  String get getToken => token ?? '';

  @override
  String toString() => 'User(name: $name, token: $token)';

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.name == name && other.token == token;
  }

  @override
  int get hashCode => Object.hash(name, token);
}
