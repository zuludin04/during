import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/service/cache_service.dart';
import 'package:get/get.dart';

class HomeNavigationController extends GetxController {
  final DuringRepository _repository = Get.find();

  var todayTransaction = <TransactionEntity>[].obs;
  var savings = <SavingEntity>[].obs;
  var emptyTransaction = false.obs;
  var incomes = 0.obs;
  var expenses = 0.obs;
  var emptySaving = true.obs;
  var hideSlider = true.obs;

  var todayTime = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    hideSlider.value = CacheService.to.hideSlider;
    loadSavingList();
    loadIncomes();
    loadExpenses();
    loadDailyTransactions();
  }

  void loadSavingList() async {
    var result = await _repository.loadSaving();
    savings.value = result;
    emptySaving.value = result.isEmpty;
  }

  void loadDailyTransactions() async {
    var start = DateTime(todayTime.year, todayTime.month, todayTime.day, 0, 0);
    var end = DateTime(todayTime.year, todayTime.month, todayTime.day, 23, 59);
    var result = await _repository.loadDailyTransactions(
        start.millisecondsSinceEpoch, end.millisecondsSinceEpoch);
    if (result.isEmpty) {
      emptyTransaction.value = true;
    } else {
      emptyTransaction.value = false;
      todayTransaction.value = result;
    }
  }

  void loadIncomes() async {
    var start = DateTime(todayTime.year, todayTime.month, todayTime.day, 0, 0);
    var end = DateTime(todayTime.year, todayTime.month, todayTime.day, 23, 59);
    var result = await _repository.countTotalIncome(
        start.millisecondsSinceEpoch, end.millisecondsSinceEpoch);
    incomes.value = result;
  }

  void loadExpenses() async {
    var start = DateTime(todayTime.year, todayTime.month, todayTime.day, 0, 0);
    var end = DateTime(todayTime.year, todayTime.month, todayTime.day, 23, 59);
    var result = await _repository.countTotalExpense(
        start.millisecondsSinceEpoch, end.millisecondsSinceEpoch);
    expenses.value = result;
  }
}
