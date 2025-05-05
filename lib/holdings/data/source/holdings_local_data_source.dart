import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../domain/models/holding.dart';

abstract class HoldingsLocalDataSource {
  Future<List<Holding>> getHoldings();

  Future<void> cacheHoldings(List<Holding> holdings);
}

class HoldingsLocalDataSourceImpl implements HoldingsLocalDataSource {
  // In a real app, this would use shared preferences or hive or similar
  List<Holding> _cachedHoldings = [];

  @override
  Future<List<Holding>> getHoldings() async {
    try {
      if (_cachedHoldings.isEmpty) {
        // Return default test data if no cache
        return [
          const Holding(
            symbol: 'CACHED-STOCK',
            name: 'Cached Stock Ltd',
            ltp: 1000.0,
            change: 10.0,
            changePercentage: 1.0,
            quantity: 5,
            avgPrice: 990.0,
            investmentValue: 4950.0,
            currentValue: 5000.0,
            pnl: 50.0,
            pnlPercentage: 1.01,
          ),
        ];
      }
      return _cachedHoldings;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheHoldings(List<Holding> holdings) async {
    try {
      _cachedHoldings = holdings;
    } catch (e) {
      throw CacheException();
    }
  }
}