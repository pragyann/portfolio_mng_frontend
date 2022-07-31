import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';

class ProfitLossWidget extends StatelessWidget {
  const ProfitLossWidget({
    Key? key,
    required this.profit,
  }) : super(key: key);

  final int profit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildProfitLossIcon(profit),
        const SizedBox(width: 8),
        Text(
          profit.isNegative
              ? 'Rs. ${profit.toString().substring(1)}'
              : 'Rs. $profit',
          style: TextStyle(
            color: _getColor(profit),
          ),
        ),
      ],
    );
  }

  _buildProfitLossIcon(int profit) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: _getColor(profit),
        shape: BoxShape.circle,
      ),
      child: _getIcon(profit),
    );
  }

  _getColor(int profit) {
    return profit == 0
        ? ColorPalette.grey()
        : profit.isNegative
            ? Colors.red
            : Colors.green;
  }

  _getIcon(int profit) {
    return Icon(
      profit == 0
          ? Icons.remove
          : profit.isNegative
              ? Icons.arrow_downward
              : Icons.arrow_upward,
      color: Colors.white,
      size: 10,
    );
  }
}
