import 'package:during/core/color_extension.dart';
import 'package:during/core/header_text.dart';
import 'package:during/core/string_extension.dart';
import 'package:during/core/toolbar_during.dart';
import 'package:during/ui/transaction/controllers/transaction_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionDetailController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('Transaction Detail'),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(16),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetBuilder<TransactionDetailController>(
                builder: (controller) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    color: controller.transaction.color!.convertStringToColor(),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                          text: 'From ',
                          style: TextStyle(
                            fontSize: 16,
                            color: controller.transaction.color!
                                .dynamicTextColor(),
                          ),
                          children: [
                            TextSpan(
                              text: controller.saving,
                              style: TextStyle(
                                color: controller.transaction.color!
                                    .dynamicTextColor(),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Text(
                'Rp ${_controller.transaction.nominal!.toPriceFormat()}',
                style: TextStyle(
                  fontSize: 26,
                  color: _controller.transaction.type == 'Income'
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                _controller.transaction.date!
                    .changeDateFormat('dd MMM yyyy, HH:mm'),
                style: TextStyle(color: Colors.black87),
              ),
              _transactionInfo('Name', '${_controller.transaction.name}'),
              _transactionInfo('Type', '${_controller.transaction.type}'),
              _transactionInfo(
                  'Category', '${_controller.transaction.category}'),
              SizedBox(height: 16),
              Divider(color: Colors.black12, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Delete Transaction',
                        content:
                            Text('Are you sure want to delete transaction?'),
                        confirm: TextButton(
                          onPressed: () {
                            Get.back();
                            _controller.deleteTransaction();
                          },
                          child: Text('OK'),
                        ),
                        cancel: TextButton(
                          onPressed: () => Get.back(),
                          child: Text('Cancel'),
                        ),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: _controller.updateTransaction,
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _transactionInfo(String header, String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          HeaderText(title: header, showTrailing: false, titleSize: 15),
          Text(
            item,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
