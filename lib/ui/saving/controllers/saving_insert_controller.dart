import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/saving_entity.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingInsertController extends GetxController {
  final DuringRepository _repository = Get.find();

  var name = ''.obs;
  var balance = ''.obs;
  var color = ''.obs;
  var category = 'Bank'.obs;

  void insertSaving() async {
    if (color.value == '') color.value = ColorTools.colorCode(Colors.blue);

    SavingEntity saving = SavingEntity(
      name: name.value,
      balance: int.parse(balance.value),
      color: color.value,
      date: DateTime.now().millisecondsSinceEpoch,
      category: category.value,
    );

    await _repository.insertSaving(saving);
    Get.back(result: true);
  }
}
