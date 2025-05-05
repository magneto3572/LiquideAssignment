import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../model/broker.dart';
import '../model/user.dart';


abstract class LoginRepository {
  Future<Either<Failure, List<Broker>>> getBrokers();

  Future<Either<Failure, User>> login({
    required String brokerId,
    required String username,
    required String password,
  });

  Future<Either<Failure, bool>> logout();

  Future<Either<Failure, User?>> getCurrentUser();
}