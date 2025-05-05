import 'package:equatable/equatable.dart';
import '../../domain/models/order.dart';

abstract class OrderbookEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetOrdersEvent extends OrderbookEvent {
  GetOrdersEvent();
}

class PlaceOrderEvent extends OrderbookEvent {
  final String symbol;
  final OrderType type;
  final int quantity;
  final double price;

  PlaceOrderEvent({
    required this.symbol,
    required this.type,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [symbol, type, quantity, price];
}