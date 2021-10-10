import 'package:during/core/utils/helper.dart';
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
      appBar: ToolbarDuring.defaultToolbar('Records'),
      body: Column(
        children: [
          _filterBar(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Text('Text #$index');
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: kToolbarHeight / 2,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 80,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xffFFA400),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      dateRangeFilters[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
                itemCount: dateRangeFilters.length,
              ),
            ),
          ),
          SizedBox(
            width: 50,
            child: GestureDetector(
              onTap: () async {
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
              child: Icon(
                Icons.filter_list,
                color: Color(0xff373A36),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
