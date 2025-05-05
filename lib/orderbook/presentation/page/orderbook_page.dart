import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/orderbook_bloc.dart';
import '../bloc/orderbook_event.dart';
import '../bloc/orderbook_state.dart';
import '../../domain/models/order.dart';
import '../../../core/error/failures.dart';

class OrderbookPage extends StatefulWidget {
  const OrderbookPage({super.key});

  @override
  State<OrderbookPage> createState() => _OrderbookPageState();
}

class _OrderbookPageState extends State<OrderbookPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderbookBloc>().add(GetOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderbookBloc, OrderbookState>(
      builder: (context, state) {
        if (state is OrderbookLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrdersLoaded) {
          final orders = state.orders;

          if (orders.isEmpty) {
            return const Center(child: Text('No orders found'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrderbookBloc>().add(GetOrdersEvent());
            },
            child: ListView.separated(
              itemCount: orders.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text('${order.symbol} - ${order.name}'),
                  subtitle: Text('${order.type
                      .toString()
                      .split('.')
                      .last} - ${order.quantity} @ ₹${order.price
                      .toStringAsFixed(2)}'),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₹${order.value.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(order.status
                          .toString()
                          .split('.')
                          .last,
                          style: TextStyle(
                            color: _getStatusColor(order.status),
                            fontSize: 12,
                          )),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is OrderbookError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        return const Center(child: Text('No data available'));
      },
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.executed:
        return Colors.green;
      case OrderStatus.rejected:
        return Colors.red;
      case OrderStatus.pending:
        return Colors.orange;
    }
  }
}