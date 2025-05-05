import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart' as dartz;

enum OrderType { buy, sell }
enum OrderStatus { executed, rejected, pending }

class Order extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final OrderType type;
  final OrderStatus status;
  final int quantity;
  final double price;
  final double value;
  final DateTime timestamp;
  final double? pnl;

  const Order({
    required this.id,
    required this.symbol,
    required this.name,
    required this.type,
    required this.status,
    required this.quantity,
    required this.price,
    required this.value,
    required this.timestamp,
    this.pnl,
  });

  @override
  List<Object?> get props =>
      [
        id,
        symbol,
        name,
        type,
        status,
        quantity,
        price,
        value,
        timestamp,
        pnl,
      ];
}