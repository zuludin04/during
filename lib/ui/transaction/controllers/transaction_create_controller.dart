import 'package:during/core/extensions/string_extension.dart';
import 'package:during/core/utils/base_controller.dart';
import 'package:during/core/utils/constants.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/statistic_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:during/ui/saving/controllers/saving_detail_controller.dart';
import 'package:get/get.dart';

class TransactionCreateController extends BaseController {
  String? transactionType = Get.parameters['transaction'];
  SavingEntity saving = SavingEntity();
  TransactionEntity transaction = TransactionEntity();
  var totalTransaction = 0;

  var name = ''.obs;
  var nominal = ''.obs;
  var date = 0.obs;
  var type = 'Income'.obs;
  var pickedSaving = 'Choose Saving'.obs;
  var selectedCategory = CategoryEntity().obs;
  var transactionId = 0;

  var expenseCategory = <CategoryEntity>[].obs;
  var incomeCategory = <CategoryEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTransaction();
    loadCategory();
    if (transactionType! == 'Update') {
      transaction = Get.arguments;
      _loadInitialValue();
    } else {
      type.value = Get.parameters['type'] ?? "Income";
      date.value = DateTime.now().millisecondsSinceEpoch;
    }
  }

  void createTransaction() async {
    if (selectedCategory.value.name == 'category_empty'.tr) {
      Get.rawSnackbar(message: 'Please choose saving category');
      return;
    }

    TransactionEntity transaction = TransactionEntity(
      type: type.value,
      date: date.value,
      nominal: int.parse(nominal.value),
      categoryId: selectedCategory.value.id,
      name: name.value,
      savingId: saving.id,
      savingName: saving.name,
    );

    if (transactionType! == 'Update') {
      await repository.updateTransaction(transaction..id = transactionId);
      await repository.updateSavingBalance(saving.id, savingBalance(true));
      Get.find<TransactionController>().loadSavingTotalBalance();
      Get.find<TransactionController>().loadDailyTransactions();
      Get.find<SavingController>().loadSavingList();
      Get.find<StatisticController>().loadInitialStatistic();
      if (Get.parameters['source'] == 'saving') {
        Get.find<SavingDetailController>().loadSavingTransactions();
        Get.find<SavingDetailController>().loadDetailSaving();
      }
      Get.back();
      Get.back();
    } else {
      await repository.saveTransaction(transaction);
      await repository.updateSavingBalance(saving.id, savingBalance(false));
      Get.back(result: 'OK');
    }
  }

  void loadTransaction() async {
    var transaction = await repository.loadTransactions();
    totalTransaction = transaction.length + 1;
  }

  void pickSaving() async {
    var result =
        await Get.toNamed(RoutePath.savingList, arguments: savingPickedType);
    if (result != null) {
      if (result is SavingEntity) {
        saving = result;
        pickedSaving.value =
            '${result.name} - (Rp ${result.balance!.toPriceFormat()})';
      }
    }
  }

  void changeCategoryList(String type) {
    if (type == 'Income') {
      if (incomeCategory.isEmpty) {
        selectedCategory.value = CategoryEntity(name: 'category_empty'.tr);
      } else {
        selectedCategory.value = incomeCategory[0];
      }
    } else {
      if (expenseCategory.isEmpty) {
        selectedCategory.value = CategoryEntity(name: 'category_empty'.tr);
      } else {
        selectedCategory.value = expenseCategory[0];
      }
    }
  }

  void _loadInitialValue() async {
    transactionId = transaction.id!;
    name.value = transaction.name!;
    nominal.value = transaction.nominal!.toPriceFormat();
    type.value = transaction.type!;
    date.value = transaction.date!;

    var savingResult = await repository.loadSingleSaving(transaction.savingId!);
    saving = savingResult;
    pickedSaving.value =
        '${savingResult.name} - (Rp ${savingResult.balance!.toPriceFormat()})';

    changeCategoryList(type.value);

    var category = await repository.loadSingleCategory(transaction.categoryId!);
    selectedCategory.value = category;
  }

  int savingBalance(bool update) {
    if (update) {
      return type.value == 'Income'
          ? saving.balance! - (transaction.nominal! - int.parse(nominal.value))
          : saving.balance! + (transaction.nominal! - int.parse(nominal.value));
    } else {
      return type.value == 'Income'
          ? saving.balance! + int.parse(nominal.value)
          : saving.balance! - int.parse(nominal.value);
    }
  }

  Future<void> loadCategory() async {
    var incomeResult = await repository.loadCategoryType(2);
    incomeCategory.value = incomeResult;

    var expenseResult = await repository.loadCategoryType(3);
    expenseCategory.value = expenseResult;

    changeCategoryList(type.value);
  }
}
