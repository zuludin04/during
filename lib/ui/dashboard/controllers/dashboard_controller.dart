import 'package:during/data/during_repository.dart';
import 'package:during/service/cache_service.dart';
import 'package:during/service/language_service.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final DuringRepository _repository = Get.find();

  var navIndex = 0;

  void changeNavIndex(int index) {
    navIndex = index;
    update();
  }

  @override
  void onInit() {
    Get.updateLocale(LanguageService.deviceLocale);
    loadInitialCategory();
    super.onInit();
  }

  void loadInitialCategory() {
    if (!CacheService.to.loadInitialCategory) {
      _repository
          .initialCategory()
          .then((value) => CacheService.to.loadInitialCategory = true);
    }
  }
}
