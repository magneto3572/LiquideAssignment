import 'package:equatable/equatable.dart';

abstract class LoginBaseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetBrokersEvent extends LoginBaseEvent {}

class LoginEvent extends LoginBaseEvent {
  final String brokerId;
  final String username;
  final String password;

  LoginEvent({
    required this.brokerId,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [brokerId, username, password];
}

class LogoutEvent extends LoginBaseEvent {}

class CheckLoginStatusEvent extends LoginBaseEvent {}