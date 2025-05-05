

import 'package:liquide_assignment/login/domain/model/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.brokerId,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      brokerId: json['brokerId'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brokerId': brokerId,
      'token': token,
    };
  }
}