import 'package:equatable/equatable.dart';
import '../../domain/models/order.dart';

abstract class OrderbookState extends Equatable {
  const OrderbookState();

  @override
  List<Object?> get props => [];
}

class OrderbookInitial extends OrderbookState {
  const OrderbookInitial();
}

class OrderbookLoading extends OrderbookState {
  const OrderbookLoading();
}

class OrdersLoaded extends OrderbookState {
  final List<Order> orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrderPlaced extends OrderbookState {
  final bool success;

  const OrderPlaced(this.success);

  @override
  List<Object?> get props => [success];
}

class OrderbookError extends OrderbookState {
  final String message;

  const OrderbookError(this.message);

  @override
  List<Object?> get props => [message];
}