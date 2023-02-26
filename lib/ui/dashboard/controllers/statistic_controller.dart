import 'package:during/core/utils/base_controller.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:get/get.dart';

class StatisticController extends BaseController {
  var income = 0.obs;
  var expense = 0.obs;
  var total = 0.obs;
  var incomeTransactions = <TransactionEntity>[].obs;
  var expenseTransactions = <TransactionEntity>[].obs;

  var currentDate = DateTime.now();

  @override
  void onInit() {
    loadInitialStatistic();
    super.onInit();
  }

  void loadInitialStatistic() {
    var startMonth = DateTime(currentDate.year, currentDate.month, 1);
    var endMonth = DateTime(currentDate.year, currentDate.month + 1, 0);
    loadStatisticData(
        startMonth.millisecondsSinceEpoch, endMonth.millisecondsSinceEpoch);
  }

  void changeMonthStatistic(bool nextMonth) {
    var showMonth = nextMonth ? currentDate.month + 1 : currentDate.month - 1;
    currentDate = DateTime(currentDate.year, showMonth);
    update();

    var startMonth = DateTime(currentDate.year, currentDate.month, 1);
    var endMonth = DateTime(currentDate.year, currentDate.month + 1, 0);
    loadStatisticData(
        startMonth.millisecondsSinceEpoch, endMonth.millisecondsSinceEpoch);
  }

  void loadStatisticData(int start, int end) async {
    var result = await repository.loadDailyTransactions(start, end);
    var incomes = result.where((element) => element.type == 'Income').toList();
    var expenses =
        result.where((element) => element.type == 'Expense').toList();

    if (incomes.isNotEmpty) {
      var total = 0;
      for (var element in incomes) {
        total += element.nominal!;
      }
      income.value = total;
    } else {
      income.value = 0;
    }

    if (expenses.isNotEmpty) {
      var total = 0;
      for (var element in expenses) {
        total += element.nominal!;
      }
      expense.value = total;
    } else {
      expense.value = 0;
    }

    total.value = income.value - expense.value;

    incomeTransactions.value = incomes;
    expenseTransactions.value = expenses;
  }
}
