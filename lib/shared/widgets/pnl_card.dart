import 'package:flutter/material.dart';

class PnlCard extends StatelessWidget {
  final String title;
  final double investment;
  final double currentValue;
  final double pnl;
  final double pnlPercentage;
  final String? subtitle;

  const PnlCard({
    Key? key,
    required this.title,
    required this.investment,
    required this.currentValue,
    required this.pnl,
    required this.pnlPercentage,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isGain = pnl >= 0;
    final pnlColor = isGain ? Colors.green : Colors.red;

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatBox(
                  label: 'Invested',
                  value: '₹${investment.toStringAsFixed(2)}',
                ),
                _buildStatBox(
                  label: 'Current',
                  value: '₹${currentValue.toStringAsFixed(2)}',
                ),
                _buildStatBox(
                  label: 'P&L',
                  value: '${isGain ? '+' : ''}₹${pnl.toStringAsFixed(2)}',
                  valueColor: pnlColor,
                ),
                _buildStatBox(
                  label: 'P&L %',
                  value: '${isGain ? '+' : ''}${pnlPercentage.toStringAsFixed(
                      2)}%',
                  valueColor: pnlColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}