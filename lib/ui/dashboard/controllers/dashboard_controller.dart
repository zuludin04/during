import 'package:during/data/during_repository.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/service/cache_service.dart';
import 'package:during/service/language_service.dart';
import 'package:during/ui/dashboard/controllers/home_navigation_controller.dart';
import 'package:during/ui/dashboard/controllers/transaction_navigation_controller.dart';
import 'package:during/ui/dashboard/views/widgets/filter_bottom_sheet.dart';
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

  void filterTransaction() {
    Get.bottomSheet(
      FilterBottomSheet(),
      isScrollControlled: false,
      ignoreSafeArea: false,
    );
  }

  void addSaving() async {
    var result = await Get.toNamed(RoutePath.savingInsert, arguments: {
      'status': 'create',
    });
    if (result != null) {
      if (result == true) {
        Get.find<HomeNavigationController>().loadSavingList();
      }
    }
  }

  void resetData() async {
    _repository.resetAllData().then((value) {
      Get.find<TransactionNavigationController>().loadInitialTransactions();
      Get.find<HomeNavigationController>().loadSavingList();
      Get.find<HomeNavigationController>().loadIncomes();
      Get.find<HomeNavigationController>().loadExpenses();
      Get.find<HomeNavigationController>().loadDailyTransactions();
      changeNavIndex(0);
    });
  }
}
