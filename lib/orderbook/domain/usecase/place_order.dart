import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../models/order.dart';
import '../repository/order_repository.dart';

class PlaceOrder implements UseCase<bool, PlaceOrderParams> {
  final OrderRepository repository;

  PlaceOrder(this.repository);

  @override
  Future<Either<Failure, bool>> call(PlaceOrderParams params) {
    return repository.placeOrder(
      symbol: params.symbol,
      type: params.type,
      quantity: params.quantity,
      price: params.price,
    );
  }
}

class PlaceOrderParams extends Equatable {
  final String symbol;
  final OrderType type;
  final int quantity;
  final double price;

  const PlaceOrderParams({
    required this.symbol,
    required this.type,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [symbol, type, quantity, price];
}