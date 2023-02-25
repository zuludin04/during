import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:get/get.dart';

class SavingDetailController extends GetxController {
  final DuringRepository _repository = Get.find();
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
    var result = await _repository.loadSingleSaving(savingId);
    saving = result;
    update();
  }

  void loadSavingTransactions() async {
    var results = await _repository.loadSavingTransactions(savingId);
    transactions = results;
    update();
  }

  void deleteSaving() async {
    await _repository.deleteSaving(savingId);
    await _repository.deleteSavingTransactions(transactions);
    Get.find<SavingController>().loadSavingList();
    Get.find<TransactionController>().loadDailyTransactions();
    Get.find<TransactionController>().loadSavingTotalBalance();
    Get.back();
  }
}
