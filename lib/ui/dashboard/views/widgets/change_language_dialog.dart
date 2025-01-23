import 'package:during/service/cache_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageDialog extends StatefulWidget {
  const ChangeLanguageDialog({super.key});

  @override
  State<ChangeLanguageDialog> createState() => _ChangeLanguageDialogState();
}

class _ChangeLanguageDialogState extends State<ChangeLanguageDialog> {
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
    return Column(
      children: [
        _languageItem(
          'English',
          _languageSelected[0],
          () {
            changeTypeState(0);
            CacheService.to.selectedLanguage = 'en_US';
            Get.updateLocale(const Locale('en', 'US'));
            Get.back();
          },
        ),
        _languageItem(
          'Bahasa Indonesia',
          _languageSelected[1],
          () {
            changeTypeState(1);
            CacheService.to.selectedLanguage = 'id_ID';
            Get.updateLocale(const Locale('id', 'ID'));
            Get.back();
          },
        ),
      ],
    );
  }

  Widget _languageItem(String title, bool selected, Function() onTap) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      leading: Icon(
        Icons.check,
        color:
            selected ? Theme.of(context).iconTheme.color : Colors.transparent,
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
