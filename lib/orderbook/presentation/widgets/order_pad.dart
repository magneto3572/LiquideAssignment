import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/models/stock.dart';
import '../../../shared/models/order_pad_type.dart';
import '../../domain/models/order.dart';
import '../bloc/orderbook_bloc.dart';
import '../bloc/orderbook_event.dart';

class OrderPad extends StatefulWidget {
  final Stock stock;
  final OrderPadType type;

  const OrderPad({
    Key? key,
    required this.stock,
    required this.type,
  }) : super(key: key);

  @override
  State<OrderPad> createState() => _OrderPadState();
}

class _OrderPadState extends State<OrderPad> {
  late TextEditingController _quantityController;
  late TextEditingController _priceController;
  double _total = 0.0;
  bool _isMarketOrder = false;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: '1');
    _priceController = TextEditingController(text: widget.stock.ltp.toString());
    _calculateTotal();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _calculateTotal() {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    setState(() {
      _total = quantity * price;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isGreen = widget.type == OrderPadType.buy;
    final primaryColor = isGreen ? Colors.green : Colors.red;
    final backgroundColor = isGreen ? Colors.green.shade50 : Colors.red.shade50;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.type == OrderPadType.buy
                            ? 'Buy Order'
                            : 'Sell Order',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.stock.symbol,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.stock.name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₹${widget.stock.ltp.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: widget.stock.change >= 0 ? Colors.green
                              .shade800 : Colors.red.shade800,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${widget.stock.change >= 0 ? '+' : ''}${widget.stock
                              .changePercentage.toStringAsFixed(2)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SwitchListTile(
                          title: const Text('Market Order'),
                          value: _isMarketOrder,
                          activeColor: primaryColor,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (value) {
                            setState(() {
                              _isMarketOrder = value;
                              if (_isMarketOrder) {
                                _priceController.text =
                                    widget.stock.ltp.toString();
                              }
                              _calculateTotal();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _quantityController,
                          decoration: InputDecoration(
                            labelText: 'Quantity',
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            prefixIcon: Icon(
                                Icons.numbers, color: primaryColor),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (_) => _calculateTotal(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText: 'Price',
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                            prefixIcon: Icon(
                                Icons.currency_rupee, color: primaryColor),
                          ),
                          keyboardType: TextInputType.number,
                          readOnly: _isMarketOrder,
                          onChanged: (_) => _calculateTotal(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Order Summary',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Value:'),
                            Text(
                              '₹${_total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Place order
                      final quantity =
                          int.tryParse(_quantityController.text) ?? 0;
                      final price =
                          double.tryParse(_priceController.text) ?? 0.0;

                      if (quantity <= 0 || price <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Please enter valid quantity and price')),
                        );
                        return;
                      }

                      // Place the order
                      context.read<OrderbookBloc>().add(
                        PlaceOrderEvent(
                          symbol: widget.stock.symbol,
                          type: widget.type == OrderPadType.buy
                              ? OrderType.buy
                              : OrderType.sell,
                          quantity: quantity,
                          price: price,
                        ),
                      );

                      Navigator.pop(context);

                      // Show a snackbar to indicate order was placed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${widget.type == OrderPadType.buy
                                ? 'Buy'
                                : 'Sell'} order placed successfully!',
                          ),
                          backgroundColor: primaryColor,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      widget.type == OrderPadType.buy
                          ? 'Place Buy Order'
                          : 'Place Sell Order',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}