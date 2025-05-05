import '../../domain/models/holding.dart';

class HoldingModel extends Holding {
  const HoldingModel({
    required super.symbol,
    required super.name,
    required super.ltp,
    required super.change,
    required super.changePercentage,
    required super.quantity,
    required super.avgPrice,
    required super.investmentValue,
    required super.currentValue,
    required super.pnl,
    required super.pnlPercentage,
  });

  factory HoldingModel.fromJson(Map<String, dynamic> json) {
    return HoldingModel(
      symbol: json['symbol'],
      name: json['name'],
      ltp: json['ltp'].toDouble(),
      change: json['change'].toDouble(),
      changePercentage: json['changePercentage'].toDouble(),
      quantity: json['quantity'],
      avgPrice: json['avgPrice'].toDouble(),
      investmentValue: json['investmentValue'].toDouble(),
      currentValue: json['currentValue'].toDouble(),
      pnl: json['pnl'].toDouble(),
      pnlPercentage: json['pnlPercentage'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'ltp': ltp,
      'change': change,
      'changePercentage': changePercentage,
      'quantity': quantity,
      'avgPrice': avgPrice,
      'investmentValue': investmentValue,
      'currentValue': currentValue,
      'pnl': pnl,
      'pnlPercentage': pnlPercentage,
    };
  }
}