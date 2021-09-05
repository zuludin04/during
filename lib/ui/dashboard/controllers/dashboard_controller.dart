import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final DuringRepository _repository = Get.find();

  var todayTransaction = <TransactionEntity>[].obs;
  var savings = <SavingEntity>[].obs;
  var emptyTransaction = false.obs;
  var incomes = 0.obs;
  var expenses = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavingList();
    loadIncomes();
    loadExpenses();
    loadTodayTransaction();
  }

  void loadSavingList() async {
    var result = await _repository.loadSaving();
    savings.value = result;
  }

  void loadTodayTransaction() async {
    var result = await _repository.loadTodayTransaction();
    if (result.isEmpty) {
      emptyTransaction.value = true;
    } else {
      emptyTransaction.value = false;
      todayTransaction.value = result;
    }
  }

  void loadIncomes() async {
    var result = await _repository.countTotalIncome();
    incomes.value = result;
  }

  void loadExpenses() async {
    var result = await _repository.countTotalExpense();
    expenses.value = result;
  }
}
