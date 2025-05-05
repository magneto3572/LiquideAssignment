import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String symbol;
  final String name;
  final double ltp;
  final double change;
  final double changePercentage;
  final int quantity;

  const Stock({
    required this.symbol,
    required this.name,
    required this.ltp,
    required this.change,
    required this.changePercentage,
    this.quantity = 0,
  });

  @override
  List<Object?> get props =>
      [symbol, name, ltp, change, changePercentage, quantity];
}