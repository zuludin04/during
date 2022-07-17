import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_navigation_controller.dart';
import 'package:during/ui/saving/controllers/saving_detail_controller.dart';
import 'package:get/get.dart';

class TransactionDetailController extends GetxController {
  final DuringRepository _repository = Get.find();

  TransactionEntity transaction = Get.arguments;
  SavingEntity saving = SavingEntity();
  String source = Get.parameters['source'] ?? 'normal';

  @override
  void onInit() {
    super.onInit();
    loadTransactionSaving();
  }

  void loadTransactionSaving() async {
    var result = await _repository.loadSingleSaving(transaction.savingId!);
    saving = result;
    update();
  }

  void deleteTransaction() async {
    await _repository.deleteTransaction(transaction.id);
    await _repository.updateSavingBalance(saving.id, savingBalance());
    Get.find<HomeNavigationController>().loadDailyTransactions();
    Get.find<HomeNavigationController>().loadSavingList();
    Get.find<HomeNavigationController>().loadIncomes();
    Get.find<HomeNavigationController>().loadExpenses();
    Get.find<TransactionNavigationController>().loadInitialTransactions();
    if (source == 'saving') {
      Get.find<SavingDetailController>().loadSavingTransactions();
    }
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
