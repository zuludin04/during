import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/utils/helper.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/core/widgets/transaction_item.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/ui/saving/controllers/saving_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SavingDetailScreen extends StatelessWidget {
  final SavingEntity _saving = Get.arguments;
  final SavingDetailController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'Saving',
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Delete Saving',
                content: Text('Are you sure want to delete saving?'),
                confirm: TextButton(
                  onPressed: () {
                    Get.back();
                    _controller.deleteSaving();
                  },
                  child: Text('OK'),
                ),
                cancel: TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Cancel'),
                ),
              );
            },
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, color: Colors.black),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Rp ${_saving.balance!.toPriceFormat()}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            iconAssetByCategory(_saving.category ?? 'Other'),
                            width: 35,
                            height: 35,
                          ),
                          SizedBox(width: 10),
                          Text(
                            _saving.name ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Type'),
                          Text(
                            _saving.category ?? '',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Created'),
                          Text(
                            _saving.date!.changeDateFormat('MM/yy'),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  HeaderText(title: 'Transactions', showTrailing: false),
                ],
              ),
            ),
          ),
          GetBuilder<SavingDetailController>(
            builder: (controller) {
              if (controller.loading) {
                return _loadTransactionIndicator(true);
              } else if (controller.empty) {
                return _loadTransactionIndicator(false);
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        TransactionItem(controller.transactions[index]),
                    childCount: controller.transactions.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _loadTransactionIndicator(bool loading) {
    return SliverToBoxAdapter(
      child: Center(
        child: loading
            ? CircularProgressIndicator()
            : Text('Transaction is Empty'),
      ),
    );
  }
}
