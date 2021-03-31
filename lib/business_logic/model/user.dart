class UserModel {
  final String name;
  final String email;
  final String phone;
  final String role;

  UserModel({
    this.name,
    this.phone,
    this.email,
    this.role,
  });

  UserModel.fromJson(Map<String, dynamic> map)
      : name = map[UserMap.user][UserMap.name],
        email = map[UserMap.user][UserMap.email],
        role = map[UserMap.user][UserMap.role],
        phone = map[UserMap.user][UserMap.phone];

  UserModel.fromJsonLocally(Map<String, dynamic> map)
      : name = map[UserMap.name],
        email = map[UserMap.email],
        role = map[UserMap.role],
        phone = map[UserMap.phone];

  Map<String, dynamic> toJson() => {
        UserMap.name: name,
        UserMap.email: email,
        UserMap.phone: phone,
        UserMap.role: role,
      };
}

class UserMap {
  static const name = 'name';
  static const email = 'email';
  static const phone = 'phone';
  static const token = 'token';
  static const user = 'user';
  static const role = 'role';
  static const pwd = 'password';
}
