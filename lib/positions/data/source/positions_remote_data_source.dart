import '../../../core/error/exceptions.dart';
import '../../domain/models/position.dart';

abstract class PositionsRemoteDataSource {
  Future<List<Position>> getPositions();
}

class PositionsRemoteDataSourceImpl implements PositionsRemoteDataSource {
  @override
  Future<List<Position>> getPositions() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Return mock data
      return [
        const Position(
          symbol: 'RELIANCE',
          name: 'Reliance Industries',
          ltp: 2550.0,
          change: 50.0,
          changePercentage: 2.0,
          quantity: 10,
          entryPrice: 2500.0,
          pnl: 500.0,
          pnlPercentage: 2.0,
          isOpen: true,
        ),
        const Position(
          symbol: 'INFY',
          name: 'Infosys Ltd.',
          ltp: 1450.0,
          change: -50.0,
          changePercentage: -3.33,
          quantity: 5,
          entryPrice: 1500.0,
          pnl: -250.0,
          pnlPercentage: -3.33,
          isOpen: true,
        ),
        const Position(
          symbol: 'TATAMOTORS',
          name: 'Tata Motors Ltd.',
          ltp: 470.0,
          change: 20.0,
          changePercentage: 4.44,
          quantity: 20,
          entryPrice: 450.0,
          pnl: 400.0,
          pnlPercentage: 4.44,
          isOpen: true,
        ),
      ];
    } catch (e) {
      throw ServerException();
    }
  }
}