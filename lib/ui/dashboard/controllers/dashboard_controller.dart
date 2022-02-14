import 'package:get/get.dart';

class DashboardController extends GetxController {
  var navIndex = 0;
  
  void changeNavIndex(int index) {
    navIndex = index;
    update();
  }
}
