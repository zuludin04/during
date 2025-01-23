import 'package:during/core/utils/base_controller.dart';
import 'package:during/core/utils/constants.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/saving_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_controller.dart';
import 'package:get/get.dart';

class TransferController extends BaseController {
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

    await repository.saveTransaction(transaction);
    await repository.updateSavingBalance(
        target ? targetSaving.id : sourceSaving.id, savingBalance(target));
    Get.find<TransactionController>().loadDailyTransactions();
    Get.find<SavingController>().loadSavingList();
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
