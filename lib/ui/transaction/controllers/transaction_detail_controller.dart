import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:get/get.dart';

class TransactionDetailController extends GetxController {
  final DuringRepository _repository = Get.find();

  TransactionEntity transaction = Get.arguments;
  String saving = '';

  @override
  void onInit() {
    super.onInit();
    loadTransactionSaving();
  }

  void loadTransactionSaving() async {
    var result = await _repository.loadSingleSaving(transaction.savingId!);
    saving = result.name ?? '';
    update();
  }
}
