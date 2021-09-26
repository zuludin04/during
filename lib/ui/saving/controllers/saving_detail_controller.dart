import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:get/get.dart';

class SavingDetailController extends GetxController {
  final DuringRepository _repository = Get.find();
  final SavingEntity saving = Get.arguments;

  List<TransactionEntity> transactions = [];
  bool loading = false;
  bool empty = false;

  @override
  void onInit() {
    super.onInit();
    loadSavingTransactions();
  }

  void loadSavingTransactions() async {
    loading = true;

    var results = await _repository.loadSavingTransactions(saving.id!);

    if (results.isEmpty) {
      empty = true;
    } else {
      empty = false;
      transactions = results;
    }

    loading = false;
    update();
  }
}