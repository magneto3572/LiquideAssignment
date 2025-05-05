import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquide_assignment/holdings/presentation/bloc/holdings_bloc.dart';
import 'package:liquide_assignment/orderbook/presentation/bloc/orderbook_bloc.dart';
import 'package:liquide_assignment/positions/presentation/bloc/positions_bloc.dart';
import 'positions/presentation/page/positions_page.dart';
import 'shared/models/order_pad_type.dart';
import 'shared/widgets/draggable_fab.dart';
import 'orderbook/presentation/widgets/order_pad.dart';
import 'holdings/presentation/page/holdings_page.dart';
import 'holdings/presentation/bloc/holdings_event.dart';
import 'orderbook/presentation/page/orderbook_page.dart';
import 'orderbook/domain/models/order.dart';
import 'orderbook/domain/models/order_stock_adapter.dart';
import 'orderbook/presentation/bloc/orderbook_event.dart';
import 'orderbook/presentation/bloc/orderbook_state.dart';
import 'positions/presentation/bloc/positions_event.dart';

class HomePage extends StatefulWidget {
  final Key? key;

  const HomePage({this.key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HoldingsPage(),
    const OrderbookPage(),
    PositionsPage(),
  ];

  final List<String> _titles = ['Holdings', 'Orderbook', 'Positions'];

  @override
  void initState() {
    super.initState();
    // Initialize data
    context.read<HoldingsBloc>().add(GetHoldingsEvent());
    context.read<OrderbookBloc>().add(GetOrdersEvent());
    context.read<PositionsBloc>().add(GetPositionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Holdings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Orderbook',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_line_chart),
            label: 'Positions',
          ),
        ],
      ),
      floatingActionButton: DraggableFAB(
        onBuy: () => _showOrderPad(context, OrderPadType.buy),
        onSell: () => _showOrderPad(context, OrderPadType.sell),
      ),
    );
  }

  void _showOrderPad(BuildContext context, OrderPadType type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocBuilder<OrderbookBloc, OrderbookState>(
          builder: (context, state) {
            if (state is OrdersLoaded && state.orders.isNotEmpty) {
              final selectedStock = state.orders.first;
              return OrderPad(
                stock: OrderStockAdapter.fromOrder(selectedStock),
                type: type,
              );
            }
            return Container(
              height: 200,
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      },
    );
  }
}