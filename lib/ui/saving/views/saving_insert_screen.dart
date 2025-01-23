import 'package:during/core/utils/constants.dart';
import 'package:during/core/widgets/category_picker.dart';
import 'package:during/core/widgets/input_section.dart';
import 'package:during/core/widgets/input_text_field.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/ui/saving/controllers/saving_insert_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingInsertScreen extends StatefulWidget {
  const SavingInsertScreen({super.key});

  @override
  State<SavingInsertScreen> createState() => _SavingInsertScreenState();
}

class _SavingInsertScreenState extends State<SavingInsertScreen> {
  final _formKey = GlobalKey<FormState>();
  final SavingInsertController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'insert'.tr,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _controller.insertSaving();
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
                Obx(
                  () => CategoryPicker(
                    title: 'category'.tr,
                    dialogTitle: 'saving_category'.tr,
                    value: _controller.selectedCategory.value.name ?? "",
                    categories: _controller.savingCategory,
                    onSelectedCategory: (cat) =>
                        _controller.selectedCategory.value = cat,
                  ),
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'name'.tr,
                  hint: 'name'.tr,
                  onSaved: _controller.name,
                  text: _controller.name.value,
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'balance'.tr,
                  hint: 'balance'.tr,
                  onSaved: _controller.balance,
                  keyboardType: TextInputType.phone,
                  text: _controller.balance.value,
                  currencyFormat: true,
                ),
                const SizedBox(height: 16),
                InputSection(
                  title: 'color'.tr,
                  child: DropdownButtonHideUnderline(
                    child: Obx(() {
                      return DropdownButton<String>(
                        value: _controller.color.value,
                        items: categoryColors
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 72,
                                      decoration: BoxDecoration(
                                        color: Color(int.parse('0xff$e')),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          _controller.color.value = value ?? "F44336";
                        },
                        isExpanded: true,
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
