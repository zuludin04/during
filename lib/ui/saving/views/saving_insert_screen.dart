import 'package:during/core/utils/helper.dart';
import 'package:during/core/widgets/category_picker.dart';
import 'package:during/core/widgets/color_dialog.dart';
import 'package:during/core/widgets/input_text_field.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/ui/saving/controllers/saving_insert_controller.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingInsertScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final SavingInsertController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'Insert',
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _controller.insertSaving();
              }
            },
            icon: Icon(
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
                Obx(
                  () => CategoryPicker(
                    title: 'Category',
                    dialogTitle: 'Saving Category',
                    value: _controller.category.value,
                    categories: savingCategories,
                    onSelectedCategory: (cat) =>
                        _controller.category.value = cat,
                  ),
                ),
                SizedBox(height: 16),
                InputTextField(
                  title: 'Name',
                  hint: 'Name',
                  onSaved: _controller.name,
                ),
                SizedBox(height: 16),
                InputTextField(
                  title: 'Balance',
                  hint: 'Balance',
                  onSaved: _controller.balance,
                  keyboardType: TextInputType.number,
                  currencyFormat: true,
                ),
                SizedBox(height: 16),
                ColorDialog(selectedColor: (Color color) {
                  _controller.color.value = ColorTools.colorCode(color);
                }),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
