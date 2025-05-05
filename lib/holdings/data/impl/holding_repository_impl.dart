import 'package:dartz/dartz.dart';
import 'package:liquide_assignment/holdings/domain/repository/holdings_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../holdings/domain/models/holding.dart';
import '../source/holdings_remote_data_source.dart';

class HoldingRepositoryImpl implements HoldingsRepository {
  final HoldingsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HoldingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Holding>>> getHoldings() async {
    if (await networkInfo.isConnected) {
      try {
        final holdings = await remoteDataSource.getHoldings();
        return Right(holdings);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
      // try {
      //   final localHoldings = await localDataSource.getCachedHoldings();
      //   return Right(localHoldings);
      // } on CacheException catch (e) {
      //   return Left(CacheFailure(message: e.message));
      // }
    }
  }
}