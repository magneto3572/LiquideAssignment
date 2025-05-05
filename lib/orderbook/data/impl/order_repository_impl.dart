import 'package:dartz/dartz.dart' as dartz;
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import '../../domain/models/order.dart';
import '../../domain/repository/order_repository.dart';
import '../source/orderbook_local_data_source.dart';
import '../source/orderbook_remote_data_source.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderbookRemoteDataSource remoteDataSource;
  final OrderbookLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<dartz.Either<Failure, List<Order>>> getOrders() async {
    try {
      if (await networkInfo.isConnected) {
        final orders = await remoteDataSource.getOrders();
        return dartz.Right(orders);
      } else {
        // Use local data when offline
        final orders = await localDataSource.getOrders();
        return dartz.Right(orders);
      }
    } on ServerException {
      return dartz.Left(ServerFailure());
    } on CacheException {
      return dartz.Left(CacheFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, bool>> placeOrder({
    required String symbol,
    required OrderType type,
    required int quantity,
    required double price,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final success = await remoteDataSource.placeOrder(
          symbol: symbol,
          type: type
              .toString()
              .split('.')
              .last,
          quantity: quantity,
          price: price,
        );
        return dartz.Right(success);
      } else {
        return dartz.Left(NetworkFailure());
      }
    } on ServerException {
      return dartz.Left(ServerFailure());
    }
  }
}