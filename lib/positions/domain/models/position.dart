import 'package:equatable/equatable.dart';
import '../../../shared/models/stock.dart';

class Position extends Stock {
  final double entryPrice;
  final double pnl;
  final double pnlPercentage;
  final bool isOpen;

  const Position({
    required String symbol,
    required String name,
    required double ltp,
    required double change,
    required double changePercentage,
    required int quantity,
    required this.entryPrice,
    required this.pnl,
    required this.pnlPercentage,
    required this.isOpen,
  }) : super(
          symbol: symbol,
          name: name,
          ltp: ltp,
          change: change,
          changePercentage: changePercentage,
          quantity: quantity,
        );

  @override
  List<Object?> get props =>
      [
        ...super.props,
        entryPrice,
        pnl,
        pnlPercentage,
        isOpen,
      ];
}