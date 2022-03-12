import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentTransaction extends StatelessWidget {
  final HomeNavigationController controller = Get.find();

  CurrentTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.emptyTransaction.value) {
        return SliverToBoxAdapter(
          child: Container(
            height: 300,
            alignment: Alignment.center,
            child: const Text('Empty Transaction'),
          ),
        );
      } else {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => TransactionItem(
              transaction: controller.todayTransaction[index],
              source: 'normal',
            ),
            childCount: controller.todayTransaction.length > 8
                ? 8
                : controller.todayTransaction.length,
          ),
        );
      }
    });
  }
}
