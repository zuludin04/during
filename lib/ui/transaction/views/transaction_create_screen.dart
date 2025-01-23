import 'package:during/core/widgets/category_picker.dart';
import 'package:during/core/widgets/date_dialog.dart';
import 'package:during/core/widgets/input_section.dart';
import 'package:during/core/widgets/input_text_field.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/ui/transaction/controllers/transaction_create_controller.dart';
import 'package:during/ui/transaction/views/widgets/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionCreateScreen extends StatefulWidget {
  const TransactionCreateScreen({super.key});

  @override
  State<TransactionCreateScreen> createState() =>
      _TransactionCreateScreenState();
}

class _TransactionCreateScreenState extends State<TransactionCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TransactionCreateController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'transaction'.tr,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (_controller.pickedSaving.value == 'Choose Saving') {
                  Get.rawSnackbar(message: 'Pick your account saving');
                  return;
                }

                if (_controller.savingBalance(false) < 0) {
                  Get.rawSnackbar(
                      message: 'Your account balance will be minus.');
                  return;
                }
                _controller.createTransaction();
              }
            },
            icon: const Icon(Icons.check),
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
                TransactionType(controller: _controller),
                const SizedBox(height: 16),
                Obx(
                  () => CategoryPicker(
                    title: 'category'.tr,
                    dialogTitle: _controller.type.value == 'Income'
                        ? 'income_category'.tr
                        : 'expense_category'.tr,
                    value: _controller.selectedCategory.value.name ?? "",
                    categories: _controller.type.value == 'Income'
                        ? _controller.incomeCategory
                        : _controller.expenseCategory,
                    onSelectedCategory: (cat) =>
                        _controller.selectedCategory.value = cat,
                  ),
                ),
                const SizedBox(height: 16),
                InputSection(
                  title: 'saving'.tr,
                  child: InkWell(
                    onTap: () {
                      _controller.pickSaving();
                    },
                    child: Obx(
                      () => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: Text(
                          _controller.pickedSaving.value == 'Choose Saving'
                              ? 'choose_saving'.tr
                              : _controller.pickedSaving.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'total'.tr,
                  hint: 'total'.tr,
                  onSaved: _controller.nominal,
                  keyboardType: TextInputType.phone,
                  text: _controller.nominal.value,
                  currencyFormat: true,
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'name'.tr,
                  hint: 'name'.tr,
                  text: _controller.name.value,
                  onSaved: _controller.name,
                ),
                const SizedBox(height: 16),
                DateDialog(
                  selectedDate: (int date) {
                    _controller.date.value = date;
                  },
                  currentDate: DateTime.fromMillisecondsSinceEpoch(
                      _controller.date.value),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
