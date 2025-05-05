import 'package:flutter/material.dart';
import '../models/stock.dart';

class StockListItem extends StatelessWidget {
  final Stock stock;
  final VoidCallback? onBuy;
  final VoidCallback? onSell;

  const StockListItem({
    Key? key,
    required this.stock,
    this.onBuy,
    this.onSell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isGain = stock.change >= 0;
    final Color changeColor = isGain ? Colors.green : Colors.red;

    return ListTile(
      title: Text(
        stock.symbol,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(stock.name),
          if (stock.quantity > 0)
            Text(
              'Qty: ${stock.quantity}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
        ],
      ),
      trailing: Container(
        width: 120,
        padding: const EdgeInsets.only(right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '₹${stock.ltp.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${isGain ? '+' : ''}${stock.change.toStringAsFixed(2)} (${stock
                  .changePercentage.toStringAsFixed(2)}%)',
              style: TextStyle(
                color: changeColor,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            if (onBuy != null && onSell != null)
              const SizedBox(height: 4),
            if (onBuy != null && onSell != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildActionButton(
                    onTap: onBuy!,
                    isGreen: true,
                    label: 'Buy',
                  ),
                  const SizedBox(width: 8),
                  _buildActionButton(
                    onTap: onSell!,
                    isGreen: false,
                    label: 'Sell',
                  ),
                ],
              ),
          ],
        ),
      ),
      isThreeLine: stock.quantity > 0 || (onBuy != null && onSell != null),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onTap,
    required bool isGreen,
    required String label,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isGreen ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}