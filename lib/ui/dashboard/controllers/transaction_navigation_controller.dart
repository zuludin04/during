import 'package:during/data/during_repository.dart';
import 'package:during/data/model/filter_transaction.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:get/get.dart';

class TransactionNavigationController extends GetxController {
  final DuringRepository _repository = Get.find();

  var transactions = <TransactionEntity>[].obs;
  var currentDate = DateTime.now();

  FilterTransaction filtered = FilterTransaction(
    range: 1,
    type: 1,
    category: 0,
  );

  var filterRange = 1;
  var filterType = 1;
  var typed = 1.obs;
  var filterCategory = 0.obs;

  String transactionType = 'Income';
  String? transactionCategory;
  String filterCategories = '';

  var emptyTransaction = false.obs;

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
    FilterTransaction filter = FilterTransaction(
      range: filterRange,
      type: filterType,
      category: filterCategory.value,
    );
    filtered = filter;

    var result = await _repository.filterTransactions(
        _getFilterRange(filterRange), transactionType, transactionCategory);
    if (result.isEmpty) {
      emptyTransaction.value = true;
    } else {
      emptyTransaction.value = false;
      transactions.value = result;
    }

    filterCategory.value = 0;
    transactionCategory = null;
    Get.back();
  }

  void changeFilterRange(int range, String title) {
    filterRange = range;
  }

  void changeFilterType(int type, String title) {
    filterType = type;
    typed.value = type;
    transactionType = title;
    filterCategory.value = 0;
  }

  void changeFilterCategory(int category, String title) {
    filterCategory.value = category;
    transactionCategory = title;
  }

  String _getFilterRange(int range) {
    var start =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 0, 0);
    var end = start.add(const Duration(hours: 23, minutes: 59));

    if (range == 1) {
      end = start.add(const Duration(hours: 23, minutes: 59));
    } else if (range == 2) {
      end = start.add(const Duration(days: 7));
    } else if (range == 3) {
      end = start.add(const Duration(days: 30));
    }

    return '${start.millisecondsSinceEpoch} AND ${end.millisecondsSinceEpoch}';
  }
}
