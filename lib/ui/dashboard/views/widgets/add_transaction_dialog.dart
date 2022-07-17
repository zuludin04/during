import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTransactionDialog extends StatelessWidget {
  final HomeNavigationController _controller = Get.find();

  AddTransactionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _transactionMenu('Income', Icons.download),
          _transactionMenu('Expense', Icons.upload),
          // _transactionMenu('Sharing', Icons.share),
        ],
      ),
    );
  }

  Widget _transactionMenu(String title, IconData icon) {
    return InkWell(
      onTap: () async {
        Get.back();
        if (title != 'Sharing') {
          var result =
              await Get.toNamed(RoutePath.transactionCreate, parameters: {
            'transaction': 'Create',
            'type': title,
          });
          if (result != null) {
            if (result == 'Income') {
              _controller.loadIncomes();
              _controller.loadDailyTransactions();
            } else if (result == 'Expense') {
              _controller.loadExpenses();
              _controller.loadDailyTransactions();
            }
            _controller.loadSavingList();
            Get.find<TransactionNavigationController>()
                .loadInitialTransactions();
          }
        } else {
          Get.toNamed(RoutePath.sharePayment);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
          ),
          Text(title.toLowerCase().tr),
        ],
      ),
    );
  }
}
