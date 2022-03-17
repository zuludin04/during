import 'package:during/core/widgets/empty_layout.dart';
import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/ui/dashboard/controllers/transaction_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionNavigation extends StatelessWidget {
  final TransactionNavigationController _controller = Get.find();

  TransactionNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.emptyTransaction.value) {
        return Center(
          child: EmptyLayout(message: 'empty_transaction'.tr),
        );
      } else {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TransactionItem(
              transaction: _controller.transactions[index],
              source: 'normal',
            );
          },
          itemCount: _controller.transactions.length,
        );
      }
    });
  }
}
