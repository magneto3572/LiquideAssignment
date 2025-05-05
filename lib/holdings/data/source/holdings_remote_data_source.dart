import 'dart:math';

import '../../../core/error/exceptions.dart';
import '../models/holding_model.dart';

abstract class HoldingsRemoteDataSource {
  Future<List<HoldingModel>> getHoldings();
}

class HoldingsRemoteDataSourceImpl implements HoldingsRemoteDataSource {
  @override
  Future<List<HoldingModel>> getHoldings() async {
    try {
      await Future.delayed(
          const Duration(milliseconds: 800)); // Simulate network delay

      List<HoldingModel> holdings = [
        const HoldingModel(
          symbol: 'Swiggy',
          name: 'Swiggy India Ltd',
          ltp: 2500.75,
          change: 15.50,
          changePercentage: 0.62,
          quantity: 10,
          avgPrice: 2450.30,
          investmentValue: 24503.00,
          currentValue: 25007.50,
          pnl: 504.50,
          pnlPercentage: 2.06,
        ),
        const HoldingModel(
          symbol: 'Adani port',
          name: 'Adani ltd',
          ltp: 3450.20,
          change: -25.30,
          changePercentage: -0.73,
          quantity: 5,
          avgPrice: 3500.00,
          investmentValue: 17500.00,
          currentValue: 17251.00,
          pnl: -249.00,
          pnlPercentage: -1.42,
        ),
        const HoldingModel(
          symbol: 'Tata Motors',
          name: 'Tata Motors Ltd',
          ltp: 1680.45,
          change: 5.75,
          changePercentage: 0.34,
          quantity: 15,
          avgPrice: 1650.20,
          investmentValue: 24753.00,
          currentValue: 25206.75,
          pnl: 455.75,
          pnlPercentage: 1.83,
        ),
        const HoldingModel(
          symbol: 'Sonata Software',
          name: 'Sonata Software Ltd',
          ltp: 1280.45,
          change: 5.75,
          changePercentage: 0.34,
          quantity: 15,
          avgPrice: 1350.20,
          investmentValue: 26753.00,
          currentValue: 28206.75,
          pnl: 4233.75,
          pnlPercentage: 2.83,
        ),
      ];
      return holdings;
    } catch (e) {
      throw ServerException();
    }
  }
}