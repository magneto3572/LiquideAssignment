import '../../../core/error/exceptions.dart';
import '../../domain/models/position.dart';

abstract class PositionsLocalDataSource {
  Future<List<Position>> getPositions();

  Future<void> cachePositions(List<Position> positions);
}

class PositionsLocalDataSourceImpl implements PositionsLocalDataSource {
  // In a real app, this would use shared preferences or hive or similar
  List<Position> _cachedPositions = [];

  @override
  Future<List<Position>> getPositions() async {
    try {
      if (_cachedPositions.isEmpty) {
        // Return empty list if no cache, or default values for testing
        return [
          const Position(
            symbol: 'RELIANCE-CACHED',
            name: 'Reliance Industries (Cached)',
            ltp: 2550.0,
            change: 50.0,
            changePercentage: 2.0,
            quantity: 10,
            entryPrice: 2500.0,
            pnl: 500.0,
            pnlPercentage: 2.0,
            isOpen: true,
          ),
        ];
      }
      return _cachedPositions;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePositions(List<Position> positions) async {
    try {
      _cachedPositions = positions;
    } catch (e) {
      throw CacheException();
    }
  }
}