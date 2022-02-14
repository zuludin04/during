import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/data/model/filter_transaction.dart';
import 'package:during/ui/transaction/controllers/transaction_filter_controller.dart';
import 'package:during/ui/transaction/views/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionNavigation extends StatelessWidget {
  final TransactionFilterController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _dashboardAppBar(),
          Obx(() {
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
          })
        ],
      ),
    );
  }

  Widget _dashboardAppBar() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xff373A36),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'ZM',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffFFA400),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
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
    );
  }
}
