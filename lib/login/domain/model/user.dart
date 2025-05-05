import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String brokerId;
  final String token;

  const User({
    required this.id,
    required this.name,
    required this.brokerId,
    required this.token,
  });

  @override
  List<Object?> get props => [id, name, brokerId, token];
}