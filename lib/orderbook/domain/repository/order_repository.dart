import 'package:dartz/dartz.dart' as dartz;
import '../../../core/error/failures.dart';
import '../models/order.dart';

abstract class OrderRepository {
  Future<dartz.Either<Failure, List<Order>>> getOrders();

  Future<dartz.Either<Failure, bool>> placeOrder({
    required String symbol,
    required OrderType type,
    required int quantity,
    required double price,
  });
}