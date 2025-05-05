import '../../../shared/models/stock.dart';
import 'order.dart';

// This adapter transforms an Order into a Stock object that can be used with the OrderPad widget
class OrderStockAdapter extends Stock {
  const OrderStockAdapter({
    required String symbol,
    required String name,
    required double price,
    double change = 0.0,
    double changePercentage = 0.0,
    int quantity = 0,
  }) : super(
    symbol: symbol,
    name: name,
    ltp: price,
    change: change,
    changePercentage: changePercentage,
    quantity: quantity,
  );

  // Factory constructor to create from an Order
  factory OrderStockAdapter.fromOrder(Order order) {
    return OrderStockAdapter(
      symbol: order.symbol,
      name: order.name,
      price: order.price,
      quantity: order.quantity,
    );
  }
}