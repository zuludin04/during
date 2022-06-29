import 'package:during/core/utils/constants.dart';
import 'package:during/core/extensions/string_extension.dart';
import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:get/get.dart';

class TransactionCreateController extends GetxController {
  final DuringRepository _repository = Get.find();

  String? transactionType = Get.parameters['transaction'];
  SavingEntity saving = SavingEntity();
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
    if (transactionType! == 'Update') {
      _loadInitialValue(Get.arguments);
    } else {
      type.value = Get.parameters['type'] ?? "Income";
      date.value = DateTime.now().millisecondsSinceEpoch;
    }

    loadCategory(2);
    loadCategory(3);
  }

  void createTransaction() async {
    TransactionEntity transaction = TransactionEntity(
      type: type.value,
      date: date.value,
      nominal: int.parse(nominal.value),
      categoryId: selectedCategory.value.id,
      name: name.value,
      color: saving.color,
      savingId: saving.id,
    );

    if (transactionType! == 'Update') {
      await _repository.updateTransaction(transaction..id = transactionId);
    } else {
      await _repository.saveTransaction(transaction);
    }
    await _repository.updateSavingBalance(saving.id, savingBalance());
    Get.back(result: type.value);
  }

  void loadTransaction() async {
    var transaction = await _repository.loadTodayTransaction();
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
      selectedCategory.value = incomeCategory[0];
    } else {
      selectedCategory.value = expenseCategory[0];
    }
  }

  void _loadInitialValue(TransactionEntity transaction) async {
    transactionId = transaction.id!;
    name.value = transaction.name!;
    nominal.value = transaction.nominal!.toPriceFormat();
    type.value = transaction.type!;
    date.value = transaction.date!;

    var savingResult =
        await _repository.loadSingleSaving(transaction.savingId!);
    saving = savingResult;
    pickedSaving.value =
        '${savingResult.name} - (Rp ${savingResult.balance!.toPriceFormat()})';
  }

  int savingBalance() {
    return type.value == 'Income'
        ? saving.balance! + int.parse(nominal.value)
        : saving.balance! - int.parse(nominal.value);
  }

  void loadCategory(int type) async {
    if (type == 2) {
      var result = await _repository.loadCategoryType(type);
      incomeCategory.value = result;
      changeCategoryList('Income');
    }

    if (type == 3) {
      var result = await _repository.loadCategoryType(type);
      expenseCategory.value = result;
      changeCategoryList('Expense');
    }
  }
}
