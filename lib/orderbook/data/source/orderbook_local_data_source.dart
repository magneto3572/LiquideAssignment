import '../../../core/error/exceptions.dart';
import '../../domain/models/order.dart';

abstract class OrderbookLocalDataSource {
  Future<List<Order>> getOrders();

  Future<bool> placeOrder({
    required String symbol,
    required String type,
    required int quantity,
    required double price,
  });

  Future<void> cacheOrders(List<Order> orders);
}

class OrderbookLocalDataSourceImpl implements OrderbookLocalDataSource {
  // In a real app, this would use shared preferences or hive or similar
  List<Order> _cachedOrders = [];

  @override
  Future<List<Order>> getOrders() async {
    try {
      if (_cachedOrders.isEmpty) {
        // If empty, return a default cached item for demo purposes
        return [
          Order(
            id: 'cached-1',
            symbol: 'CACHED',
            name: 'Cached Stock',
            type: OrderType.buy,
            status: OrderStatus.pending,
            quantity: 10,
            price: 1000.0,
            value: 10000.0,
            timestamp: DateTime.now(),
          ),
        ];
      }
      return _cachedOrders;
    } catch (e) {
      throw CacheException();
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
      // Create an order and add it to cache
      final order = Order(
        id: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        symbol: symbol,
        name: '$symbol Company',
        type: type == 'buy' ? OrderType.buy : OrderType.sell,
        status: OrderStatus.pending,
        quantity: quantity,
        price: price,
        value: price * quantity,
        timestamp: DateTime.now(),
      );

      _cachedOrders = [..._cachedOrders, order];
      return true;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheOrders(List<Order> orders) async {
    try {
      _cachedOrders = orders;
    } catch (e) {
      throw CacheException();
    }
  }
}