import 'package:during/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionInfo extends StatelessWidget {
  final int income;
  final int expense;

  const TransactionInfo({
    Key? key,
    required this.income,
    required this.expense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Row(
        children: [
          const SizedBox(width: 10),
          _transaction(Colors.green, 'Income', income),
          const SizedBox(width: 10),
          _transaction(Colors.red, 'Expense', expense),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _transaction(Color color, String type, int nominal) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              width: 45,
              height: 45,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: type == 'Income' ? Colors.green : Colors.red,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SvgPicture.asset(
                type == 'Income'
                    ? 'assets/icon_income.svg'
                    : 'assets/icon_expense.svg',
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'Rp ${nominal.toPriceFormat()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
