import 'package:during/core/utils/helper.dart';
import 'package:during/core/widgets/category_picker.dart';
import 'package:during/core/widgets/date_dialog.dart';
import 'package:during/core/widgets/header_text.dart';
import 'package:during/core/widgets/input_text_field.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/ui/transaction/controllers/transaction_create_controller.dart';
import 'package:during/ui/transaction/views/widgets/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionCreateScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TransactionCreateController _controller = Get.find();

  TransactionCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ToolbarDuring.defaultToolbar(
        'Transaction',
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (_controller.pickedSaving.value == 'Choose Saving') {
                  Get.rawSnackbar(message: 'Pick your account saving');
                  return;
                }

                if (_controller.savingBalance() < 0) {
                  Get.rawSnackbar(
                      message: 'Your account balance will be minus.');
                  return;
                }

                _controller.createTransaction();
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
                TransactionType(controller: _controller),
                const SizedBox(height: 16),
                Obx(
                  () => CategoryPicker(
                    title: 'Category',
                    dialogTitle: _controller.type.value == 'Income'
                        ? 'Income Category'
                        : 'Expense Category',
                    value: _controller.category.value,
                    categories: _controller.type.value == 'Income'
                        ? incomeCategories
                        : expenseCategories,
                    onSelectedCategory: (cat) =>
                        _controller.category.value = cat,
                  ),
                ),
                const SizedBox(height: 16),
                const HeaderText(title: 'Saving', showTrailing: false),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    _controller.pickSaving();
                  },
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
                        _controller.pickedSaving.value,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'Total',
                  hint: 'Total',
                  onSaved: _controller.nominal,
                  keyboardType: TextInputType.number,
                  text: _controller.nominal.value,
                  currencyFormat: true,
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'Name',
                  hint: 'Name',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
