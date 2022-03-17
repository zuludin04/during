import 'package:during/core/utils/language.dart';
import 'package:during/service/cache_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageService extends Translations {
  static Locale get deviceLocale => CacheService.to.selectedLanguage == 'en_US'
      ? const Locale('en', 'US')
      : const Locale('id', 'ID');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'id_ID': idID,
      };
}
