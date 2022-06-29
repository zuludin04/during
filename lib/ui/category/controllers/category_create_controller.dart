import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:during/ui/category/controllers/category_dashboard_controller.dart';
import 'package:get/get.dart';

class CategoryCreateController extends GetxController {
  final DuringRepository _repository = Get.find();

  var name = ''.obs;
  var icon = 'icon_wallet.svg'.obs;
  var type = 'Saving'.obs;

  void insertCategory() async {
    var category = CategoryEntity(
      name: name.value,
      icon: icon.value,
      type: _typeToInt(type.value),
    );

    _repository.inserteCategroy(category).then((value) {
      Get.find<CategoryDashboardController>()
          .loadCategory(_typeToInt(type.value));
      Get.back();
    });
  }

  int _typeToInt(String type) {
    switch (type) {
      case 'Saving':
        return 1;
      case 'Income':
        return 2;
      case 'Expense':
        return 3;
      default:
        return 1;
    }
  }
}
