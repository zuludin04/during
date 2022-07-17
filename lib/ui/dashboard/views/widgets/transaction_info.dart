import 'package:during/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
      height: _responsiveSliderHeight(context),
      child: Row(
        children: [
          const SizedBox(width: 10),
          _transaction(Colors.green, 'daily_income', income),
          const SizedBox(width: 10),
          _transaction(Colors.red, 'daily_expense', expense),
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
                color: type == 'daily_income' ? Colors.green : Colors.red,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SvgPicture.asset(
                type == 'daily_income'
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
                  type.tr,
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

  double _responsiveSliderHeight(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (size.width > 1000) {
      return 140.0;
    } else if (size.width >= 600 && size.width <= 1000) {
      return 100.0;
    } else {
      return 80.0;
    }
  }
}
