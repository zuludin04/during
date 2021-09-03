import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectIndex = 0;

  void changeIndex(int index) {
    selectIndex = index;
    update();
  }
}
