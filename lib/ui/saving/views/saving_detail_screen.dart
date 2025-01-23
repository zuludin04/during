import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/core/widgets/transaction_header_item.dart';
import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/saving/controllers/saving_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/sliver_grouped_list.dart';

class SavingDetailScreen extends StatelessWidget {
  const SavingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'saving'.tr,
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'delete_saving_title'.tr,
                content: Text(
                  'delete_saving_message'.tr,
                  textAlign: TextAlign.center,
                ),
                confirm: TextButton(
                  onPressed: () {
                    Get.find<SavingDetailController>().deleteSaving();
                  },
                  child: Text(
                    'ok'.tr,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
                cancel: TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'cancel'.tr,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(RoutePath.savingInsert, arguments: {
                'status': 'update',
                'saving': Get.find<SavingDetailController>().saving,
              });
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GetBuilder<SavingDetailController>(
                      builder: (controller) => Column(
                        children: [
                          Text(
                            'Rp ${controller.saving.balance!.toPriceFormat()}',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/category/${controller.saving.categoryIcon}',
                                    width: 35,
                                    height: 35,
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).iconTheme.color!,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    controller.saving.name ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('type'.tr),
                                  Text(
                                    controller.saving.categoryName ?? '',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('created'.tr),
                                  Text(
                                    controller.saving.date!
                                        .changeDateFormat('MM/yy'),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          HeaderText(
                              title: 'transaction'.tr, showTrailing: false),
                        ],
                      ),
                    ),
                  ),
                ),
                GetBuilder<SavingDetailController>(
                  builder: (controller) {
                    if (controller.transactions.isEmpty) {
                      return _loadTransactionIndicator();
                    } else {
                      return SliverGroupedListView<TransactionEntity, DateTime>(
                        elements: controller.transactions,
                        groupBy: (element) {
                          var date = DateTime.fromMillisecondsSinceEpoch(
                              element.date!);
                          return DateTime(date.year, date.month, date.day);
                        },
                        groupSeparatorBuilder: (DateTime groupByValue) =>
                            TransactionHeaderItem(date: groupByValue),
                        itemBuilder: (context, element) => TransactionItem(
                          transaction: element,
                          source: 'saving',
                        ),
                        order: GroupedListOrder.DESC,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadTransactionIndicator() {
    return SliverFillRemaining(
      child: Center(
        child: EmptyLayout(message: 'empty_transaction'.tr),
      ),
    );
  }
}
