import 'package:during/core/utils/constants.dart';
import 'package:during/core/extensions/string_extension.dart';
import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:get/get.dart';

class TransactionCreateController extends GetxController {
  final DuringRepository _repository = Get.find();

  String? transactionType = Get.parameters['transaction'];
  SavingEntity saving = SavingEntity();

  var name = ''.obs;
  var category = 'Fee'.obs;
  var nominal = ''.obs;
  var date = 0.obs;
  var type = 'Income'.obs;
  var pickedSaving = 'Choose Saving'.obs;
  var transactionId = 0;

  @override
  void onInit() {
    super.onInit();
    if (transactionType! == 'Update') {
      _loadInitialValue(Get.arguments);
    } else {
      type.value = Get.parameters['type'] ?? "Income";
      category.value = type.value == 'Income' ? 'Fee' : 'Education';
      date.value = DateTime.now().millisecondsSinceEpoch;
    }
  }

  void createTransaction() async {
    TransactionEntity transaction = TransactionEntity(
      type: type.value,
      date: date.value,
      nominal: int.parse(nominal.value),
      category: category.value,
      name: name.value,
      color: saving.color,
      savingId: saving.id,
    );

    if (transactionType! == 'Update') {
      await _repository.updateTransaction(transaction..id = transactionId);
    } else {
      await _repository.saveTransaction(transaction);
    }
    await _repository.updateSavingBalance(saving.id, savingBalance());
    Get.back(result: type.value);
  }

  void pickSaving() async {
    var result =
        await Get.toNamed(RoutePath.savingList, arguments: savingPickedType);
    if (result != null) {
      if (result is SavingEntity) {
        saving = result;
        pickedSaving.value =
            '${result.name} - (Rp ${result.balance!.toPriceFormat()})';
      }
    }
  }

  void changeCategoryList(String type) {
    if (type == 'Income') {
      category.value = 'Fee';
    } else {
      category.value = 'Education';
    }
  }

  void _loadInitialValue(TransactionEntity transaction) async {
    transactionId = transaction.id!;
    name.value = transaction.name!;
    nominal.value = transaction.nominal!.toPriceFormat();
    type.value = transaction.type!;
    category.value = transaction.category!;
    date.value = transaction.date!;

    var savingResult =
        await _repository.loadSingleSaving(transaction.savingId!);
    saving = savingResult;
    pickedSaving.value =
        '${savingResult.name} - (Rp ${savingResult.balance!.toPriceFormat()})';
  }

  int savingBalance() {
    return type.value == 'Income'
        ? saving.balance! + int.parse(nominal.value)
        : saving.balance! - int.parse(nominal.value);
  }
}
