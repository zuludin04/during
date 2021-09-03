import 'package:during/core/date_dialog.dart';
import 'package:during/core/header_text.dart';
import 'package:during/core/input_text_field.dart';
import 'package:during/core/toolbar_during.dart';
import 'package:during/ui/transaction/controllers/transaction_create_controller.dart';
import 'package:during/ui/transaction/views/widgets/category_picker.dart';
import 'package:during/ui/transaction/views/widgets/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionCreateScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TransactionCreateController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ToolbarDuring.defaultToolbar('Transaction'),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              _controller.createTransaction();
            } else {
              Get.rawSnackbar(message: 'Field can\'t be empty');
            }
          },
          child: Text(
            'Add',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TransactionType(_controller),
                  SizedBox(height: 16),
                  CategoryPicker(
                    category: _controller.category.value,
                    type: _controller.type.value,
                    onSelectedCategory: (cat) {
                      _controller.category.value = cat;
                    },
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      HeaderText(title: 'Saving', isMore: false),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          _controller.pickSaving();
                        },
                        child: Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            _controller.pickedSaving.value,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  InputTextField(
                    title: 'Total',
                    hint: 'Total',
                    onSaved: _controller.nominal,
                    keyboardType: TextInputType.number,
                    currencyFormat: true,
                  ),
                  SizedBox(height: 16),
                  InputTextField(
                    title: 'Name',
                    hint: 'Name',
                    onSaved: _controller.name,
                  ),
                  SizedBox(height: 16),
                  DateDialog((int date) {
                    _controller.date.value = date;
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
