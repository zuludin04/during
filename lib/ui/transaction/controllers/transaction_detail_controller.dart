import 'package:during/core/utils/base_controller.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/statistic_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:during/ui/saving/controllers/saving_detail_controller.dart';
import 'package:get/get.dart';

class TransactionDetailController extends BaseController {
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
    var result = await repository.loadSingleSaving(savingId);
    saving = result;
    update();
  }

  void deleteTransaction() async {
    await repository.deleteTransaction(transaction.id);
    await repository.updateSavingBalance(transaction.savingId, savingBalance());
    Get.find<TransactionController>().loadSavingTotalBalance();
    Get.find<TransactionController>().loadDailyTransactions();
    Get.find<SavingController>().loadSavingList();
    Get.find<StatisticController>().loadInitialStatistic();
    if (source == 'saving') {
      Get.find<SavingDetailController>().loadDetailSaving();
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
