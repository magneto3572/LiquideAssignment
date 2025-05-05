import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/holdings_event.dart';
import '../bloc/holdings_bloc.dart';
import '../bloc/holding_state.dart';
import '../../../shared/widgets/pnl_card.dart';
import '../../../shared/widgets/stock_list_item.dart';

class HoldingsPage extends StatefulWidget {
  const HoldingsPage({super.key});

  @override
  State<HoldingsPage> createState() => _HoldingsPageState();
}

class _HoldingsPageState extends State<HoldingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<HoldingsBloc>().add(GetHoldingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HoldingsBloc, HoldingsState>(
      builder: (context, state) {
        if (state is HoldingsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HoldingsLoaded) {
          final holdings = state.holdings;

          if (holdings.isEmpty) {
            return const Center(child: Text('No holdings found'));
          }

          // Calculate summary
          double totalInvestment = 0;
          double currentValue = 0;
          double totalPnl = 0;

          for (final holding in holdings) {
            totalInvestment += holding.avgPrice * holding.quantity;
            currentValue += holding.ltp * holding.quantity;
            totalPnl += holding.pnl;
          }

          final pnlPercentage = totalInvestment > 0
              ? (totalPnl / totalInvestment) * 100
              : 0.0;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HoldingsBloc>().add(GetHoldingsEvent());
            },
            child: Column(
              children: [
                PnlCard(
                  title: 'Portfolio Performance',
                  investment: totalInvestment,
                  currentValue: currentValue,
                  pnl: totalPnl,
                  pnlPercentage: pnlPercentage,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: holdings.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final holding = holdings[index];
                      return StockListItem(
                        stock: holding,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is HoldingsError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        return const Center(child: Text('No data available'));
      },
    );
  }
}