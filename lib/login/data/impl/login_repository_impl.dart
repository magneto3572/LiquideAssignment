import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../../domain/model/broker.dart';
import '../../domain/model/user.dart';
import '../../domain/repository/login_repository.dart';
import '../source/login_local_data_source.dart';
import '../source/login_remote_data_source.dart';



class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Broker>>> getBrokers() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteBrokers = await remoteDataSource.getBrokers();
        return Right(remoteBrokers);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String brokerId,
    required String username,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.login(
          brokerId: brokerId,
          username: username,
          password: password,
        );
        await localDataSource.cacheUser(userModel);
        return Right(userModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on AuthException catch (e) {
        return Left(AuthFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await localDataSource.clearUser();
      return const Right(true);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userModel = await localDataSource.getLastLoggedInUser();
      return Right(userModel);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}