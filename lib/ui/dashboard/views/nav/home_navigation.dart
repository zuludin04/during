import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeNavigationController controller = Get.find();

    return Obx(() {
      if (controller.emptyTransaction.value) {
        return Container(
          height: 300,
          alignment: Alignment.center,
          child: EmptyLayout(message: 'empty_transaction'.tr),
        );
      } else {
        return GroupedListView<TransactionEntity, DateTime>(
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
          order: GroupedListOrder.DESC, // optional
        );
      }
    });
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
