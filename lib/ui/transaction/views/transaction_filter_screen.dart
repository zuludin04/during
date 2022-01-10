import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/data/model/filter_transaction.dart';
import 'package:during/ui/transaction/controllers/transaction_filter_controller.dart';
import 'package:during/ui/transaction/views/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionFilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'Records',
        actions: [
          IconButton(
            onPressed: () async {
              var result = await Get.bottomSheet(
                FilterBottomSheet(),
                isScrollControlled: true,
                ignoreSafeArea: false,
              );
              if (result != null) {
                if (result is FilterTransaction) {
                  print('Filter range is ${result.range}');
                }
              } else {
                var c = Get.find<TransactionFilterController>();
                c.typed.value = c.filtered.type!;
              }
            },
            icon: Icon(
              Icons.filter_list,
              color: Color(0xff373A36),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Text('Text #$index');
        },
        itemCount: 20,
      ),
    );
  }
}
