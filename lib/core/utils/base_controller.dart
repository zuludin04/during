import 'package:during/data/during_repository.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final repository = Get.find<DuringRepository>();
}
