import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/positions_bloc.dart';
import '../bloc/positions_event.dart';
import '../bloc/positions_state.dart';
import '../../../shared/widgets/pnl_card.dart';
import '../../../shared/widgets/stock_list_item.dart';

class PositionsPage extends StatefulWidget {
  const PositionsPage({super.key});

  @override
  State<PositionsPage> createState() => _PositionsPageState();
}

class _PositionsPageState extends State<PositionsPage> {
  @override
  void initState() {
    super.initState();
    context.read<PositionsBloc>().add(GetPositionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionsBloc, PositionsState>(
      builder: (context, state) {
        if (state is PositionsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PositionsLoaded) {
          final positions = state.positions;

          if (positions.isEmpty) {
            return const Center(child: Text('No positions found'));
          }

          // Calculate summary
          double totalInvestment = 0;
          double currentValue = 0;
          double totalPnl = 0;

          for (final position in positions) {
            totalInvestment += position.entryPrice * position.quantity;
            currentValue += position.ltp * position.quantity;
            totalPnl += position.pnl;
          }

          final pnlPercentage = totalInvestment > 0
              ? (totalPnl / totalInvestment) * 100
              : 0.0;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<PositionsBloc>().add(GetPositionsEvent());
            },
            child: Column(
              children: [
                PnlCard(
                  title: 'Positions Summary',
                  investment: totalInvestment,
                  currentValue: currentValue,
                  pnl: totalPnl,
                  pnlPercentage: pnlPercentage,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: positions.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final position = positions[index];
                      return StockListItem(
                        stock: position,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is PositionsError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        return const Center(child: Text('No data available'));
      },
    );
  }
}