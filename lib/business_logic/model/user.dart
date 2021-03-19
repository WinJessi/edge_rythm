class UserModel {
  final String name;
  final String email;
  final String phone;

  UserModel({
    this.name,
    this.phone,
    this.email,
  });

  UserModel.fromJson(Map<String, dynamic> map)
      : name = map[UserMap.user][UserMap.name],
        email = map[UserMap.user][UserMap.email],
        phone = map[UserMap.user][UserMap.phone];

  UserModel.fromJsonLocally(Map<String, dynamic> map)
      : name = map[UserMap.name],
        email = map[UserMap.email],
        phone = map[UserMap.phone];

  Map<String, dynamic> toJson() => {
        UserMap.name: name,
        UserMap.email: email,
        UserMap.phone: phone,
      };
}

class UserMap {
  static const name = 'name';
  static const email = 'email';
  static const phone = 'phone';
  static const token = 'token';
  static const user = 'user';
  static const pwd = 'password';
}
