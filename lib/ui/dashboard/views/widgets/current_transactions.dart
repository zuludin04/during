import 'package:during/core/helper.dart';
import 'package:during/core/string_extension.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/ui/dashboard/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CurrentTransaction extends StatelessWidget {
  final HomeController controller;

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
                _transactionItem(controller.todayTransaction[index]),
            childCount: controller.todayTransaction.length,
          ),
        );
      }
    });
  }

  Widget _transactionItem(TransactionEntity? transaction) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(int.parse('0x${transaction!.color}')),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 1),
                      blurRadius: 3,
                      spreadRadius: 1,
                      color: Colors.black26,
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                    iconAssetByCategory(transaction.category ?? 'Other')),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      transaction.name ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      transaction.category ?? 'Other',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Rp ${transaction.nominal!.toPriceFormat()}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: transaction.type == 'Income'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    transaction.date!.changeDateFormat('dd MMM yyyy'),
                    style: TextStyle(color: Colors.black87),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.4),
        ),
      ],
    );
  }
}
