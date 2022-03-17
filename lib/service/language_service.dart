import 'package:during/core/utils/language.dart';
import 'package:get/get.dart';

class LanguageService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'id_ID': idID,
      };
}
