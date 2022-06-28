import 'package:during/data/during_repository.dart';
import 'package:during/data/source/entity/category_entity.dart';
import 'package:get/get.dart';

class CategoryDashboardController extends GetxController {
  final DuringRepository _repository = Get.find();

  var loading = false;
  var categories = <CategoryEntity>[];

  void loadCategory(int type) async {
    var category = await _repository.loadCategoryType(type);
    categories = category;
    update([type]);
  }

  String _updateKey(int type) {
    switch (type) {
      case 1:
        return 'Saving';
      case 2:
        return 'Income';
      case 3:
        return 'Expense';
      default:
        return 'Expense';
    }
  }
}
