import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../../domain/models/holding.dart';
import '../../domain/repository/holdings_repository.dart';
import '../source/holdings_local_data_source.dart';
import '../source/holdings_remote_data_source.dart';

class HoldingsRepositoryImpl implements HoldingsRepository {
  final HoldingsRemoteDataSource remoteDataSource;
  final HoldingsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HoldingsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Holding>>> getHoldings() async {
    try {
      if (await networkInfo.isConnected) {
        final holdings = await remoteDataSource.getHoldings();
        return Right(holdings);
      } else {
        final localHoldings = await localDataSource.getHoldings();
        return Right(localHoldings);
      }
    } on ServerException {
      return const Left(ServerFailure());
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}