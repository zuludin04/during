import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CacheService extends GetxService {
  static CacheService get to => Get.find();

  final GetStorage _storage = GetStorage();

  bool get showSlider => _storage.read('SHOW_SLIDER') ?? true;
  set showSlider(bool value) {
    _storage.write('SHOW_SLIDER', value);
  }

  bool get darkMode => _storage.read('DARK_MODE') ?? false;
  set darkMode(bool value) {
    _storage.write('DARK_MODE', value);
  }
}
