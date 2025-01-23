import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/utils/base_controller.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:during/ui/saving/controllers/saving_detail_controller.dart';
import 'package:during/ui/saving/controllers/saving_manage_controller.dart';
import 'package:get/get.dart';

class SavingInsertController extends BaseController {
  String type = Get.arguments['status'];
  SavingEntity saving = SavingEntity();
  var totalSaving = 0;

  var name = ''.obs;
  var balance = ''.obs;
  var color = 'F44336'.obs;
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

    SavingEntity saving = SavingEntity(
      name: name.value,
      balance: int.parse(balance.value),
      color: color.value,
      date: DateTime.now().millisecondsSinceEpoch,
      categoryId: selectedCategory.value.id,
    );

    if (type == 'update') {
      saving.id = this.saving.id!;
      await repository.updateSaving(saving);
      Get.find<SavingDetailController>().loadDetailSaving();
      Get.find<SavingController>().loadSavingList();
      Get.find<SavingManageController>().loadSavings();
      Get.find<TransactionController>().loadDailyTransactions();
      Get.find<TransactionController>().loadSavingTotalBalance();
      Get.back();
    } else {
      await repository.insertSaving(saving);
      Get.back(result: 'OK');
    }
  }

  void populateSavingData() async {
    saving = Get.arguments['saving'];
    name.value = saving.name!;
    balance.value = saving.balance!.toPriceFormat();
    color.value = saving.color!;
    selectedCategory.value =
        await repository.loadSingleCategory(saving.categoryId!);
  }

  void loadSavings() async {
    var savings = await repository.loadSaving();
    totalSaving = savings.length + 1;
  }

  void loadCategory() async {
    var result = await repository.loadCategoryType(1);
    savingCategory.value = result;
    if (savingCategory.isEmpty) {
      selectedCategory.value = CategoryEntity(name: 'category_empty'.tr);
    } else {
      selectedCategory.value = savingCategory[0];
    }
  }
}
