import 'package:during/data/during_repository.dart';
import 'package:during/data/model/filter_transaction.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:get/get.dart';

class TransactionNavigationController extends GetxController {
  final DuringRepository _repository = Get.find();

  var transactions = <TransactionEntity>[].obs;

  var startDate = DateTime.now();
  var endDate = DateTime.now();

  FilterTransaction filtered = FilterTransaction(
    range: 0,
    type: 0,
    category: 0,
  );

  var typed = 1.obs;
  var emptyTransaction = false.obs;

  // * This is for SQL Query arguments
  String transactionType = 'Income';
  String? transactionCategory;

  List<CategoryEntity> incomeCategories = [];
  List<CategoryEntity> expenseCategories = [];

  @override
  void onInit() {
    super.onInit();
    loadInitialTransactions();
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

  void filterTransaction() async {
    var result = await _repository.filterTransactions(
        _getFilterRange(), transactionType, transactionCategory);
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
    filtered = FilterTransaction(
      range: 0,
      type: 0,
      category: 0,
    );

    Get.back();
  }

  // * To handle every chips changing * //
  void changeFilterRange(int range, String title) {
    filtered.range = range;
  }

  void changeFilterType(int type, String title) {
    filtered.type = type;
    typed.value = type;
    transactionType = title;
  }

  void changeFilterCategory(int category, String title) {
    filtered.category = category;
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
