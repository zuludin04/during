import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CacheService extends GetxService {
  static CacheService get to => Get.find();

  final GetStorage _storage = GetStorage();

  bool get darkMode => _storage.read('DARK_MODE') ?? false;
  set darkMode(bool value) {
    _storage.write('DARK_MODE', value);
  }

  String get selectedLanguage => _storage.read('SELECTED_LANGUAGE') ?? 'en_US';
  set selectedLanguage(String value) {
    _storage.write('SELECTED_LANGUAGE', value);
  }

  bool get loadInitialCategory => _storage.read('INITIAL_CATEGORY') ?? false;
  set loadInitialCategory(bool value) {
    _storage.write('INITIAL_CATEGORY', value);
  }
}
