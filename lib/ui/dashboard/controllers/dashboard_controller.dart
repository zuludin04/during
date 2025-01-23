import 'package:during/core/utils/base_controller.dart';
import 'package:during/service/cache_service.dart';
import 'package:during/service/language_service.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController {
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
      repository
          .initialCategory()
          .then((value) => CacheService.to.loadInitialCategory = true);
    }
  }
}
