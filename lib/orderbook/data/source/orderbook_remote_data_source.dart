import '../../../core/error/exceptions.dart';
import '../../domain/models/order.dart';

abstract class OrderbookRemoteDataSource {
  Future<List<Order>> getOrders();

  Future<bool> placeOrder({
    required String symbol,
    required String type,
    required int quantity,
    required double price,
  });
}

class OrderbookRemoteDataSourceImpl implements OrderbookRemoteDataSource {
  final List<Order> _orderBook = [
    Order(
      id: '1',
      symbol: 'ZOMATO',
      name: 'Zomato Ltd.',
      type: OrderType.buy,
      status: OrderStatus.executed,
      quantity: 10,
      price: 120.0,
      value: 1200.0,
      timestamp: DateTime.parse('2021-09-01'),
    ),
    Order(
      id: '2',
      symbol: 'AAPL',
      name: 'Apple Ltd.',
      type: OrderType.sell,
      status: OrderStatus.rejected,
      quantity: 5,
      price: 150.0,
      value: 750.0,
      timestamp: DateTime.parse('2021-09-02'),
    ),
    Order(
      id: '3',
      symbol: 'SSNLF',
      name: 'Samsung Ltd.',
      type: OrderType.buy,
      status: OrderStatus.pending,
      quantity: 20,
      price: 220.0,
      value: 4400.0,
      timestamp: DateTime.parse('2021-09-03'),
    ),
  ];

  @override
  Future<List<Order>> getOrders() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return _orderBook;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> placeOrder({
    required String symbol,
    required String type,
    required int quantity,
    required double price,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      throw ServerException();
    }
  }
}