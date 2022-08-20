import 'package:during/data/during_repository.dart';
import 'package:during/data/model/filter_transaction.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:get/get.dart';

import '../../../data/source/entity/saving_entity.dart';

class TransactionNavigationController extends GetxController {
  final DuringRepository _repository = Get.find();

  var transactions = <TransactionEntity>[].obs;

  var startDate = DateTime.now();
  var endDate = DateTime.now();

  FilterTransaction filtered = FilterTransaction();

  var range = 0;
  var type = 0;
  var category = 0;
  var saving = 0;

  var typed = 1.obs;
  var emptyTransaction = false.obs;

  // * This is for SQL Query arguments
  String? transactionType;
  String? transactionCategory;
  String? savingFilter;

  List<CategoryEntity> incomeCategories = [];
  List<CategoryEntity> expenseCategories = [];
  List<SavingEntity> savings = [];

  @override
  void onInit() {
    super.onInit();
    loadInitialTransactions();
    loadSavings();
    loadFilterCategories();
  }

  void loadInitialTransactions() async {
    var result = await _repository.loadTransactions();
    if (result.isEmpty) {
      emptyTransaction.value = true;
    } else {
      emptyTransaction.value = false;
      transactions.value = result;
    }
  }

  void loadFilterCategories() async {
    var incomes = await _repository.loadCategoryType(2);
    incomeCategories = incomes;

    var expenses = await _repository.loadCategoryType(3);
    expenseCategories = expenses;
  }

  void loadSavings() async {
    var results = await _repository.loadSaving();
    savings = results;
  }

  void filterTransaction() async {
    var filter = FilterTransaction(
        range: range, type: type, category: category, saving: saving);
    filtered = filter;

    var result = await _repository.filterTransactions(
      range == 0 ? null : _getFilterRange(),
      transactionType,
      transactionCategory,
      savingFilter,
    );
    
    if (result.isEmpty) {
      emptyTransaction.value = true;
    } else {
      emptyTransaction.value = false;
      transactions.value = result;
    }

    Get.back(result: filtered);
  }

  void resetFilter() {
    loadInitialTransactions();
    filtered = FilterTransaction(range: 0, type: 0, category: 0, saving: 0);
    range = 0;
    type = 0;
    category = 0;
    saving = 0;

    Get.back(result: filtered);
  }

  // * To handle every chips changing * //
  void changeFilterRange(int range, String title) {
    this.range = range;
  }

  void changeFilterType(int type, String title) {
    this.type = type;
    typed.value = type;
    transactionType = title;
  }

  void changeFilterSaving(int saving, String title) {
    this.saving = saving;
    savingFilter = title;
  }

  void changeFilterCategory(int category, String title) {
    this.category = category;
    transactionCategory = title;
  }
  // * * //

  String _getFilterRange() {
    if (filtered.range != 4) {
      startDate = DateTime.now();
      endDate = DateTime.now();
    }

    var start = DateTime(startDate.year, startDate.month, startDate.day, 0, 0);
    var end = DateTime(endDate.year, endDate.month, endDate.day, 23, 59);

    if (filtered.range == 2) {
      start = start.subtract(const Duration(days: 7));
    }

    if (filtered.range == 3) {
      start = start.subtract(const Duration(days: 30));
    }

    return '${start.millisecondsSinceEpoch} AND ${end.millisecondsSinceEpoch}';
  }
}
