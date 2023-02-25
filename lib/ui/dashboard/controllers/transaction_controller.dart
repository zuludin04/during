import 'package:during/core/utils/base_controller.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:get/get.dart';

class TransactionController extends BaseController {
  var todayTransaction = <TransactionEntity>[].obs;
  var totalBalance = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDailyTransactions();
    loadSavingTotalBalance();
  }

  void loadDailyTransactions() async {
    var result = await repository.loadTransactions();
    todayTransaction.value = result;
  }

  void loadSavingTotalBalance() async {
    var balance = await repository.loadTotalSavingBalance();
    totalBalance.value = balance;
  }
}
