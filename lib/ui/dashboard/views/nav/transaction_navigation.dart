import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/ui/dashboard/controllers/transaction_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionNavigation extends StatelessWidget {
  final TransactionNavigationController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.emptyTransaction.value) {
        return Center(
          child: Text('Empty Transaction'),
        );
      } else {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TransactionItem(_controller.transactions[index], 'normal');
          },
          itemCount: _controller.transactions.length,
        );
      }
    });
  }
}
