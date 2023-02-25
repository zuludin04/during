import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/dashboard_controller.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:during/ui/dashboard/controllers/statistic_navigation_controller.dart';
import 'package:during/ui/saving/controllers/saving_detail_controller.dart';
import 'package:get/get.dart';

class TransactionDetailController extends GetxController {
  final DuringRepository _repository = Get.find();

  final TransactionEntity transaction;
  final String source;
  SavingEntity saving = SavingEntity();

  TransactionDetailController(this.transaction, this.source);

  @override
  void onInit() {
    super.onInit();
    loadTransactionSaving(transaction.savingId ?? 1);
  }

  Future<void> loadTransactionSaving(int savingId) async {
    var result = await _repository.loadSingleSaving(savingId);
    saving = result;
    update();
  }

  void deleteTransaction() async {
    await _repository.deleteTransaction(transaction.id);
    await _repository.updateSavingBalance(saving.id, savingBalance());
    Get.find<DashboardController>().loadSavingTotalBalance();
    Get.find<TransactionController>().loadDailyTransactions();
    Get.find<SavingController>().loadSavingList();
    Get.find<StatisticNavigationController>().loadInitialStatistic();
    if (source == 'saving') {
      Get.find<SavingDetailController>().loadSavingTransactions();
    }
    Get.back();
    Get.back();
  }

  int savingBalance() {
    return transaction.type == 'Income'
        ? saving.balance! - transaction.nominal!
        : saving.balance! + transaction.nominal!;
  }

  void updateTransaction() {
    Get.toNamed(RoutePath.transactionCreate,
        arguments: transaction, parameters: {'transaction': 'Update'});
  }
}
