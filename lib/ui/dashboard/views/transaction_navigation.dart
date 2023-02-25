import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class TransactionNavigation extends StatelessWidget {
  const TransactionNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionController controller = Get.find();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16),
          width: double.infinity,
          height: kToolbarHeight,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.black38),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/category/icon_emoney.svg',
                width: 30,
              ),
              const SizedBox(width: 12),
              Obx(
                () => Text(
                  'Rp ${controller.totalBalance.value.toPriceFormat()}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          if (controller.todayTransaction.isEmpty) {
            return Container(
              height: 300,
              alignment: Alignment.center,
              child: EmptyLayout(message: 'empty_transaction'.tr),
            );
          } else {
            return Expanded(
              child: GroupedListView<TransactionEntity, DateTime>(
                elements: controller.todayTransaction,
                groupBy: (element) {
                  var date = DateTime.fromMillisecondsSinceEpoch(element.date!);
                  return DateTime(date.year, date.month, date.day);
                },
                groupSeparatorBuilder: (DateTime groupByValue) =>
                    _TransactionHeaderItem(date: groupByValue),
                itemBuilder: (context, element) => TransactionItem(
                  transaction: element,
                  source: 'normal',
                ),
              ),
            );
          }
        }),
      ],
    );
  }
}

class _TransactionHeaderItem extends StatelessWidget {
  final DateTime date;

  const _TransactionHeaderItem({required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                DateFormat("MMM yyyy").format(date),
                style: const TextStyle(color: Colors.black45),
              )
            ],
          ),
        ],
      ),
    );
  }
}
