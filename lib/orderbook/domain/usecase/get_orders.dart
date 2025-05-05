import 'package:dartz/dartz.dart' as dartz;
import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../models/order.dart';
import '../repository/order_repository.dart';

class GetOrders implements UseCase<List<Order>, NoParams> {
  final OrderRepository repository;

  GetOrders(this.repository);

  @override
  Future<dartz.Either<Failure, List<Order>>> call(NoParams params) {
    return repository.getOrders();
  }
}