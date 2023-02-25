import 'package:during/core/utils/constants.dart';
import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final DuringRepository _repository = Get.find();

  var todayTransaction = <TransactionEntity>[].obs;
  var savings = <SavingEntity>[].obs;

  var todayTime = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    loadDailyTransactions();
    loadSavingList();
  }

  void loadSavingList() async {
    var result = await _repository.loadSaving();
    savings.value = result;
    savings.add(SavingEntity(name: emptySavingHash));
  }

  void loadDailyTransactions() async {
    var result = await _repository.loadTransactions();
    todayTransaction.value = result;
  }
}
