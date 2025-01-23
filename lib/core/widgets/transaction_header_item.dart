import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionHeaderItem extends StatelessWidget {
  final DateTime date;

  const TransactionHeaderItem({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Text(
            date.day.toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat("EEEE").format(date),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                DateFormat("MMM yyyy").format(date),
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ],
      ),
    );
  }
}
