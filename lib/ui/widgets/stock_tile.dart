import 'package:flutter/material.dart';
import '../../models/stock.dart';

class StockTile extends StatelessWidget {
  final Stock stock;
  final int index;

  const StockTile({required Key key, required this.stock, required this.index})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPositive = stock.changePercentage >= 0;
    final Color trendColor = isPositive
        ? Colors.greenAccent[400]!
        : Colors.redAccent[400]!;

    return Card(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ReorderableDragStartListener(
          index: index,
          child: const Icon(Icons.drag_indicator, color: Colors.white54),
        ),
        title: Text(
          stock.symbol,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          stock.name,
          style: const TextStyle(color: Colors.white60, fontSize: 12),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹${stock.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${isPositive ? '+' : ''}${stock.changePercentage}%',
              style: TextStyle(
                color: trendColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
