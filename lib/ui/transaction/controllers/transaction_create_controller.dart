import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:during/data/source/entity/transaction_entity.dart';
import 'package:during/routes/app_pages.dart';
import 'package:get/get.dart';

class TransactionCreateController extends GetxController {
  final DuringRepository _repository = Get.find();

  SavingEntity saving = SavingEntity();

  var name = ''.obs;
  var category = 'Fee'.obs;
  var nominal = ''.obs;
  var date = 0.obs;
  var type = 'Income'.obs;
  var pickedSaving = 'Choose Saving'.obs;

  @override
  void onInit() {
    super.onInit();
    date.value = DateTime.now().millisecondsSinceEpoch;
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

    await _repository.saveTransaction(transaction);
    Get.back(result: type.value);
  }

  void pickSaving() async {
    var result = await Get.toNamed(RoutePath.SAVING_LIST);
    if (result != null) {
      if (result is SavingEntity) {
        saving = result;
        pickedSaving.value = result.name ?? '';
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
}
