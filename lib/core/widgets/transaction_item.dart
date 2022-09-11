import 'package:during/core/extensions/color_extension.dart';
import 'package:during/core/extensions/string_extension.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TransactionItem extends StatelessWidget {
  final TransactionEntity transaction;
  final String source;

  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RoutePath.transactionDetail,
          arguments: transaction, parameters: {'source': source}),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(int.parse('0x${transaction.savingColor}')),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(2, 1),
                        blurRadius: 3,
                        spreadRadius: 1,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    'assets/category/${transaction.categoryIcon}',
                    color: transaction.savingColor!.dynamicTextColor(),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        transaction.name ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        transaction.categoryName ?? "",
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          transaction.type == 'Income'
                              ? Icons.add
                              : Icons.remove,
                          size: 18,
                          color: transaction.type == 'Income'
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Rp ${transaction.nominal!.toPriceFormat()}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: transaction.type == 'Income'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      transaction.date!.changeDateFormat('dd MMM yyyy, HH:mm'),
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
