import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/service/cache_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageChangeScreen extends StatefulWidget {
  const LanguageChangeScreen({Key? key}) : super(key: key);

  @override
  State<LanguageChangeScreen> createState() => _LanguageChangeScreenState();
}

class _LanguageChangeScreenState extends State<LanguageChangeScreen> {
  late List<bool> _languageSelected;

  @override
  void initState() {
    var locale = CacheService.to.selectedLanguage;
    if (locale == 'en_US') {
      _languageSelected = [true, false];
    } else {
      _languageSelected = [false, true];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('language'.tr),
      body: ListView(
        children: [
          _languageItem(
            'English',
            _languageSelected[0],
            () {
              changeTypeState(0);
              CacheService.to.selectedLanguage = 'en_US';
              Get.updateLocale(const Locale('en', 'US'));
            },
          ),
          _languageItem(
            'Bahasa Indonesia',
            _languageSelected[1],
            () {
              changeTypeState(1);
              CacheService.to.selectedLanguage = 'id_ID';
              Get.updateLocale(const Locale('id', 'ID'));
            },
          ),
        ],
      ),
    );
  }

  Widget _languageItem(String title, bool selected, Function() onTap) {
    return ListTile(
      title: Text(title),
      leading: Icon(
        Icons.check,
        color: selected ? Colors.black : Colors.transparent,
      ),
      onTap: onTap,
    );
  }

  void changeTypeState(int index) {
    setState(() {
      for (int indexBtn = 0; indexBtn < _languageSelected.length; indexBtn++) {
        if (indexBtn == index) {
          _languageSelected[indexBtn] = true;
        } else {
          _languageSelected[indexBtn] = false;
        }
      }
    });
  }
}
