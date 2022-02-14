import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/ui/transaction/controllers/transaction_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionNavigation extends StatelessWidget {
  final TransactionFilterController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.emptyTransaction.value) {
        return Expanded(
          child: Center(
            child: Text('Empty Transaction'),
          ),
        );
      } else {
        return Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(_controller.transactions[index]);
            },
            itemCount: _controller.transactions.length,
          ),
        );
      }
    });
  }
}
