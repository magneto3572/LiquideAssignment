import 'package:dartz/dartz.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../../domain/models/position.dart';
import '../../domain/repository/position_repository.dart';
import '../source/positions_local_data_source.dart';
import '../source/positions_remote_data_source.dart';

class PositionRepositoryImpl implements PositionRepository {
  final PositionsRemoteDataSource remoteDataSource;
  final PositionsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PositionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Position>>> getPositions() async {
    try {
      if (await networkInfo.isConnected) {
        final positions = await remoteDataSource.getPositions();
        return Right(positions);
      } else {
        // Use local data when offline
        final positions = await localDataSource.getPositions();
        return Right(positions);
      }
    } on ServerException {
      return const Left(ServerFailure());
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}