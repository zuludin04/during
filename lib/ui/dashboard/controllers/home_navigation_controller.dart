import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:get/get.dart';

class HomeNavigationController extends GetxController {
  final DuringRepository _repository = Get.find();

  var todayTransaction = <TransactionEntity>[].obs;
  var savings = <SavingEntity>[].obs;
  var emptyTransaction = false.obs;
  var emptySaving = true.obs;
  var hideSlider = true.obs;

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
    emptySaving.value = result.isEmpty;
  }

  void loadDailyTransactions() async {
    var result = await _repository.loadTransactions();
    if (result.isEmpty) {
      emptyTransaction.value = true;
    } else {
      emptyTransaction.value = false;
      todayTransaction.value = result;
    }
  }
}
