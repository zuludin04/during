import 'package:get/get.dart';

import '../../../core/utils/constants.dart';
import '../../../data/during_repository.dart';
import '../../../data/source/entity/saving_entity.dart';
import '../../../data/source/entity/transaction_entity.dart';
import '../../../routes/app_pages.dart';
import '../../dashboard/controllers/home_navigation_controller.dart';

class TransferController extends GetxController {
  final DuringRepository _repository = Get.find();

  var sourceSaving = SavingEntity();
  var targetSaving = SavingEntity();

  var nominal = '0'.obs;
  var date = 0.obs;
  var pickedSourceSaving = 'Choose Saving'.obs;
  var pickedTargetSaving = 'Choose Saving'.obs;
  var transactionId = 0;

  @override
  void onInit() {
    super.onInit();
    date.value = DateTime.now().millisecondsSinceEpoch;
  }

  void createTransaction(bool target) async {
    TransactionEntity transaction = TransactionEntity(
      type: target ? 'Income' : 'Expense',
      date: date.value,
      nominal: int.parse(nominal.value),
      categoryId: 1,
      name: 'From ${sourceSaving.name} To ${targetSaving.name}',
      savingId: target ? targetSaving.id : sourceSaving.id,
    );

    await _repository.saveTransaction(transaction);
    await _repository.updateSavingBalance(
        target ? targetSaving.id : sourceSaving.id, savingBalance(target));
    Get.find<HomeNavigationController>().loadDailyTransactions();
    Get.find<HomeNavigationController>().loadSavingList();
    Get.back();
  }

  int savingBalance(bool target) {
    var balance = target ? targetSaving.balance : sourceSaving.balance;
    if (target) {
      return balance! + int.parse(nominal.value);
    } else {
      return balance! - int.parse(nominal.value);
    }
  }

  void pickSaving(bool target) async {
    var result =
        await Get.toNamed(RoutePath.savingList, arguments: savingPickedType);
    if (result != null) {
      if (result is SavingEntity) {
        var pickedSaving = '${result.name}';
        if (target) {
          targetSaving = result;
          pickedTargetSaving.value = pickedSaving;
        } else {
          sourceSaving = result;
          pickedSourceSaving.value = pickedSaving;
        }
      }
    }
  }
}
