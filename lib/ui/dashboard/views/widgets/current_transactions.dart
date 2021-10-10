import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentTransaction extends StatelessWidget {
  final DashboardController controller;

  CurrentTransaction(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.emptyTransaction.value) {
        return SliverToBoxAdapter(
          child: Container(
            height: 300,
            alignment: Alignment.center,
            child: Text('Empty Transaction'),
          ),
        );
      } else {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) =>
                TransactionItem(controller.todayTransaction[index]),
            childCount: controller.todayTransaction.length > 8
                ? 8
                : controller.todayTransaction.length,
          ),
        );
      }
    });
  }
}
