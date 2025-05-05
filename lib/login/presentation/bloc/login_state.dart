import 'package:equatable/equatable.dart';
import '../../domain/model/broker.dart';
import '../../domain/model/user.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginAuthenticated extends LoginState {
  final User user;

  LoginAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginUnauthenticated extends LoginState {}

class BrokersLoaded extends LoginState {
  final List<Broker> brokers;

  BrokersLoaded(this.brokers);

  @override
  List<Object?> get props => [brokers];
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);

  @override
  List<Object?> get props => [message];
}