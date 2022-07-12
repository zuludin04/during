import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_navigation_controller.dart';
import 'package:during/ui/saving/controllers/saving_detail_controller.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingInsertController extends GetxController {
  final DuringRepository _repository = Get.find();

  String type = Get.arguments['status'];
  SavingEntity saving = SavingEntity();
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
    if (type == 'update') {
      populateSavingData();
    }
    super.onInit();
  }

  void insertSaving() async {
    if (selectedCategory.value.name == 'category_empty'.tr) {
      Get.rawSnackbar(message: 'Please choose saving category');
      return;
    }
    if (color.value == '') color.value = ColorTools.colorCode(Colors.blue);

    SavingEntity saving = SavingEntity(
      name: name.value,
      balance: int.parse(balance.value),
      color: color.value,
      date: DateTime.now().millisecondsSinceEpoch,
      categoryId: selectedCategory.value.id,
    );

    if (type == 'update') {
      saving.id = this.saving.id!;
      await _repository.updateSaving(saving);
      Get.find<SavingDetailController>().loadSavingTransactions();
      Get.find<TransactionNavigationController>().loadInitialTransactions();
      Get.find<HomeNavigationController>().loadSavingList();
      Get.find<HomeNavigationController>().loadDailyTransactions();
      Get.find<TransactionNavigationController>().loadInitialTransactions();
    } else {
      await _repository.insertSaving(saving);
    }
    Get.back(result: true);
  }

  void populateSavingData() async {
    saving = Get.arguments['saving'];
    name.value = saving.name!;
    balance.value = '${saving.balance}';
    color.value = saving.color!;
    selectedCategory.value =
        await _repository.loadSingleCategory(saving.categoryId!);
  }

  void loadSavings() async {
    var savings = await _repository.loadSaving();
    totalSaving = savings.length + 1;
  }

  void loadCategory() async {
    var result = await _repository.loadCategoryType(1);
    savingCategory.value = result;
    if (savingCategory.isEmpty) {
      selectedCategory.value = CategoryEntity(name: 'category_empty'.tr);
    } else {
      selectedCategory.value = savingCategory[0];
    }
  }
}
