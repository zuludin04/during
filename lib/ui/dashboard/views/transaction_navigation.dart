import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/core/widgets/transaction_header_item.dart';
import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

class TransactionNavigation extends StatelessWidget {
  const TransactionNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionController controller = Get.find();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16),
          width: double.infinity,
          height: kToolbarHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: const Border(bottom: BorderSide(color: Colors.black26)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/category/icon_emoney.svg',
                width: 30,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
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
                    TransactionHeaderItem(date: groupByValue),
                itemBuilder: (context, element) => TransactionItem(
                  transaction: element,
                  source: 'navigation',
                ),
                order: GroupedListOrder.DESC,
              ),
            );
          }
        }),
      ],
    );
  }
}
