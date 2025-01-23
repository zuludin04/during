import 'package:during/core/widgets/date_dialog.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/core/widgets/input_text_field.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/ui/transfer/controllers/transfer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final TransferController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'Transfer',
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _controller.createTransaction(true);
                _controller.createTransaction(false);
              }
            },
            icon: const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          HeaderText(title: 'from'.tr, showTrailing: false),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () => _controller.pickSaving(false),
                            child: Obx(
                              () => Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  _controller.pickedSourceSaving.value ==
                                          'Choose Saving'
                                      ? 'choose_saving'.tr
                                      : _controller.pickedSourceSaving.value,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        children: [
                          HeaderText(title: 'to'.tr, showTrailing: false),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () => _controller.pickSaving(true),
                            child: Obx(
                              () => Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  _controller.pickedTargetSaving.value ==
                                          'Choose Saving'
                                      ? 'choose_saving'.tr
                                      : _controller.pickedTargetSaving.value,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'total'.tr,
                  hint: 'total'.tr,
                  onSaved: _controller.nominal,
                  keyboardType: TextInputType.phone,
                  currencyFormat: true,
                ),
                const SizedBox(height: 16),
                DateDialog(
                  selectedDate: (int date) {
                    _controller.date.value = date;
                  },
                  currentDate: DateTime.fromMillisecondsSinceEpoch(
                      _controller.date.value),
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'admin_fee'.tr,
                  hint: 'admin_fee'.tr,
                  onSaved: '0'.obs,
                  keyboardType: TextInputType.phone,
                  currencyFormat: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
