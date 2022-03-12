import 'package:during/data/during_repository.dart';
import 'package:during/data/model/filter_transaction.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:get/get.dart';

class TransactionNavigationController extends GetxController {
  final DuringRepository _repository = Get.find();

  var transactions = <TransactionEntity>[].obs;
  var currentDate = DateTime.now();

  FilterTransaction filtered = FilterTransaction(
    range: 1,
    type: 0,
    category: 0,
  );

  var filterRange = 1;
  var filterType = 0;
  var typed = 0.obs;
  var filterCategory = 0;

  var transactionType;
  var transactionCategory;
  List<String> filterCategories = [];

  var emptyTransaction = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialTransactions();
  }

  void loadInitialTransactions() async {
    var result = await _repository.loadTodayTransaction();
    if (result.isEmpty) {
      emptyTransaction.value = true;
    } else {
      emptyTransaction.value = false;
      transactions.value = result;
    }
  }

  void filterTransaction() async {
    FilterTransaction filter = FilterTransaction(
      range: filterRange,
      type: filterType,
      category: filterCategory,
    );
    filtered = filter;

    var result = await _repository.filterTransactions(
        _getFilterRange(filterRange), transactionType, filterCategories);
    if (result.isEmpty) {
      emptyTransaction.value = true;
    } else {
      emptyTransaction.value = false;
      transactions.value = result;
    }

    Get.back(result: filtered);
  }

  void changeFilterRange(int range, String title, List<String> choices) {
    filterRange = range;
  }

  void changeFilterType(int type, String title, List<String> choices) {
    filterType = type;
    typed.value = type;
    transactionType = title;
    filterCategories.clear();
  }

  void changeFilterCategory(int category, String title, List<String> choices) {
    filterCategory = category;
    transactionCategory = title;
    filterCategories = choices;
  }

  String _getFilterRange(int range) {
    var start =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 0, 0);
    var end = start.add(Duration(hours: 23, minutes: 59));

    if (range == 1) {
      end = start.add(Duration(hours: 23, minutes: 59));
    } else if (range == 2) {
      end = start.add(Duration(days: 7));
    } else if (range == 3) {
      end = start.add(Duration(days: 30));
    }

    return '${start.millisecondsSinceEpoch} AND ${end.millisecondsSinceEpoch}';
  }
}
