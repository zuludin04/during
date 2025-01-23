import 'package:during/core/utils/base_controller.dart';
import 'package:during/core/utils/constants.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:get/get.dart';

class SavingController extends BaseController {
  var savings = <SavingEntity>[].obs;

  @override
  void onInit() {
    loadSavingList();
    super.onInit();
  }

  void loadSavingList() async {
    var result = await repository.loadSaving();
    savings.value = result;
    savings.add(SavingEntity(name: emptySavingHash));
  }
}
