import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => [properties];
}

class ServerFailure extends Failure {
  final String message;

  const ServerFailure({this.message = 'Server error occurred'});

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  final String message;

  const NetworkFailure({this.message = 'Network error occurred'});

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  final String message;

  const CacheFailure({this.message = 'Cache error occurred'});

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends Failure {
  final String message;

  const AuthFailure({this.message = 'Authentication failed'});

  @override
  List<Object?> get props => [message];
}