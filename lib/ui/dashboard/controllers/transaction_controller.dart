import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final DuringRepository _repository = Get.find();

  var todayTransaction = <TransactionEntity>[].obs;
  var totalBalance = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDailyTransactions();
    loadSavingTotalBalance();
  }

  void loadDailyTransactions() async {
    var result = await _repository.loadTransactions();
    todayTransaction.value = result;
  }

  void loadSavingTotalBalance() async {
    var balance = await _repository.loadTotalSavingBalance();
    totalBalance.value = balance;
  }
}
