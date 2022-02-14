import 'package:during/data/model/filter_transaction.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/ui/dashboard/controllers/home_controller.dart';
import 'package:during/ui/transaction/controllers/transaction_filter_controller.dart';
import 'package:during/ui/transaction/views/widgets/filter_bottom_sheet.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var navIndex = 0;

  void changeNavIndex(int index) {
    navIndex = index;
    update();
  }

  void filterTransaction() async {
    var result = await Get.bottomSheet(
      FilterBottomSheet(),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
    if (result != null) {
      if (result is FilterTransaction) {
        print('Filter range is ${result.range}');
      }
    } else {
      var c = Get.find<TransactionFilterController>();
      c.typed.value = c.filtered.type!;
    }
  }

  void addSaving() async {
    var result = await Get.toNamed(RoutePath.SAVING_INSERT);
    if (result != null) {
      if (result == true) {
        // Get.find<SavingListController>().loadSavings();
        Get.find<HomeController>().loadSavingList();
      }
    }
  }
}
