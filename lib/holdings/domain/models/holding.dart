import 'package:equatable/equatable.dart';
import '../../../shared/models/stock.dart';

class Holding extends Stock {
  final double avgPrice;
  final double investmentValue;
  final double currentValue;
  final double pnl;
  final double pnlPercentage;

  const Holding({
    required super.symbol,
    required super.name,
    required super.ltp,
    required super.change,
    required super.changePercentage,
    required super.quantity,
    required this.avgPrice,
    required this.investmentValue,
    required this.currentValue,
    required this.pnl,
    required this.pnlPercentage,
  });

  @override
  List<Object?> get props =>
      [
        ...super.props,
        avgPrice,
        investmentValue,
        currentValue,
        pnl,
        pnlPercentage,
      ];
}