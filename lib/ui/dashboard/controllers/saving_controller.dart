import 'package:during/core/utils/constants.dart';
import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:get/get.dart';

class SavingController extends GetxController {
  final DuringRepository _repository = Get.find();

  var savings = <SavingEntity>[].obs;

  @override
  void onInit() {
    loadSavingList();
    super.onInit();
  }

  void loadSavingList() async {
    var result = await _repository.loadSaving();
    savings.value = result;
    savings.add(SavingEntity(name: emptySavingHash));
  }
}
