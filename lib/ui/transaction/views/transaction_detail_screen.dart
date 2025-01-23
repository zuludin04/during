import 'package:during/core/extensions/color_extension.dart';
import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/ui/transaction/controllers/transaction_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionDetailScreen extends StatefulWidget {
  const TransactionDetailScreen({super.key});

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  final TransactionDetailController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('detail_transaction'.tr),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetBuilder<TransactionDetailController>(
                    builder: (controller) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: controller.transaction.categoryColor!
                              .convertStringToColor(),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: '${'from'.tr} ',
                            style: TextStyle(
                              fontSize: 16,
                              color: controller.transaction.categoryColor!
                                  .dynamicTextColor(),
                            ),
                            children: [
                              TextSpan(
                                text: controller.transaction.savingName,
                                style: TextStyle(
                                  color: controller.transaction.categoryColor!
                                      .dynamicTextColor(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 5),
                  Text(
                    _controller.transaction.date!
                        .changeDateFormat('dd MMM yyyy, HH:mm'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  _transactionInfo('Name', '${_controller.transaction.name}'),
                  _transactionInfo('Type', '${_controller.transaction.type}'),
                  _transactionInfo(
                      'Category', '${_controller.transaction.categoryName}'),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.black12, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: '',
                            content: Text(
                              _deleteMessage(
                                  _controller.transaction.categoryName ==
                                      'Transfer'),
                              textAlign: TextAlign.center,
                            ),
                            confirm: TextButton(
                              onPressed: () {
                                _controller.deleteTransaction();
                              },
                              child: Text(
                                'ok'.tr,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                            cancel: TextButton(
                              onPressed: () => Get.back(),
                              child: Text(
                                'cancel'.tr,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      Visibility(
                        visible:
                            _controller.transaction.categoryName != 'Transfer',
                        child: IconButton(
                          onPressed: _controller.updateTransaction,
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionInfo(String header, String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          HeaderText(
            title: header.toLowerCase().tr,
            showTrailing: false,
            titleSize: 15,
          ),
          Text(item, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  String _deleteMessage(bool transfer) {
    return transfer
        ? 'delete_transfer_message'.tr
        : 'delete_transaction_message'.tr;
  }
}
