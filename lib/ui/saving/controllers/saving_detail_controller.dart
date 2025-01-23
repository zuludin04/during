import 'package:during/core/utils/base_controller.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:get/get.dart';

class SavingDetailController extends BaseController {
  final int savingId = Get.arguments;

  SavingEntity saving = SavingEntity();
  List<TransactionEntity> transactions = [];

  @override
  void onInit() {
    super.onInit();
    loadSavingTransactions();
    loadDetailSaving();
  }

  void loadDetailSaving() async {
    var result = await repository.loadSingleSaving(savingId);
    saving = result;
    update();
  }

  void loadSavingTransactions() async {
    var results = await repository.loadSavingTransactions(savingId);
    transactions = results;
    update();
  }

  void deleteSaving() async {
    await repository.deleteSaving(savingId);
    Get.find<SavingController>().loadSavingList();
    Get.find<TransactionController>().loadDailyTransactions();
    Get.find<TransactionController>().loadSavingTotalBalance();
    Get.back();
    Get.back();
  }
}
