import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../model/user.dart';
import '../repository/login_repository.dart';

class Login implements UseCase<User, LoginParams> {
  final LoginRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(
      brokerId: params.brokerId,
      username: params.username,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  final String brokerId;
  final String username;
  final String password;

  const LoginParams({
    required this.brokerId,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [brokerId, username, password];
}