import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingInsertController extends GetxController {
  final DuringRepository _repository = Get.find();

  var totalSaving = 0;

  var name = ''.obs;
  var balance = ''.obs;
  var color = ''.obs;
  var selectedCategory = CategoryEntity().obs;
  var savingCategory = <CategoryEntity>[].obs;

  @override
  void onInit() {
    loadSavings();
    loadCategory();
    super.onInit();
  }

  void insertSaving() async {
    if (color.value == '') color.value = ColorTools.colorCode(Colors.blue);

    SavingEntity saving = SavingEntity(
      name: name.value,
      balance: int.parse(balance.value),
      color: color.value,
      date: DateTime.now().millisecondsSinceEpoch,
      categoryId: selectedCategory.value.id,
    );

    await _repository.insertSaving(saving);
    Get.back(result: true);
  }

  void loadSavings() async {
    var savings = await _repository.loadSaving();
    totalSaving = savings.length + 1;
  }

  void loadCategory() async {
    var result = await _repository.loadCategoryType(1);
    savingCategory.value = result;
    selectedCategory.value = savingCategory[0];
  }
}
