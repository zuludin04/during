import 'package:during/core/utils/constants.dart';
import 'package:during/routes/app_pages.dart';
import 'package:during/service/cache_service.dart';
import 'package:during/ui/dashboard/controllers/setting_controller.dart';
import 'package:during/ui/dashboard/views/widgets/change_language_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingNavigation extends StatefulWidget {
  const SettingNavigation({super.key});

  @override
  State<SettingNavigation> createState() => _SettingNavigationState();
}

class _SettingNavigationState extends State<SettingNavigation> {
  bool darkMode = CacheService.to.darkMode;

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      lightTheme: SettingsThemeData(settingsListBackground: Colors.grey[50]),
      darkTheme:
          const SettingsThemeData(settingsListBackground: Colors.black12),
      sections: [
        SettingsSection(
          title: Text('management'.tr),
          tiles: [
            SettingsTile(
              title: Text('account'.tr),
              leading: const Icon(Icons.account_balance_wallet),
              onPressed: (context) => Get.toNamed(
                RoutePath.savingList,
                arguments: savingDetailType,
              ),
            ),
            SettingsTile(
              title: Text('category'.tr),
              leading: const Icon(Icons.dashboard_rounded),
              onPressed: (context) => Get.toNamed(RoutePath.category),
            ),
            // SettingsTile(
            //   title: Text('budget'.tr),
            //   description: const Text('Under construction'),
            //   leading: const Icon(Icons.monetization_on),
            //   onPressed: (context) {},
            // ),
            // SettingsTile(
            //   title: Text('backup'.tr),
            //   description: const Text('Under construction'),
            //   leading: const Icon(Icons.backup),
            //   onPressed: (context) {},
            // ),
            SettingsTile(
              title: Text('reset'.tr),
              leading: const Icon(Icons.replay),
              onPressed: (context) {
                Get.defaultDialog(
                  title: 'reset'.tr,
                  content: Text('delete_data_message'.tr),
                  confirm: TextButton(
                    onPressed: () {
                      Get.back();
                      Get.find<SettingController>().resetData();
                    },
                    child: Text(
                      'ok'.tr,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  cancel: TextButton(
                    onPressed: Get.back,
                    child: Text(
                      'cancel'.tr,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        SettingsSection(
          title: Text('common'.tr),
          tiles: [
            SettingsTile.switchTile(
              initialValue: darkMode,
              onToggle: (value) {
                Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                CacheService.to.darkMode = value;
                setState(() {
                  darkMode = value;
                });
              },
              title: Text('dark_theme'.tr),
              leading: const Icon(Icons.dark_mode),
            ),
            SettingsTile(
              title: Text('language'.tr),
              leading: const Icon(Icons.language),
              onPressed: (context) {
                Get.defaultDialog(
                  title: '',
                  content: const ChangeLanguageDialog(),
                );
              },
            ),
            // SettingsTile(
            //   title: Text('password'.tr),
            //   leading: const Icon(Icons.lock),
            //   description: const Text('Under construction'),
            //   onPressed: (context) {},
            // ),
          ],
        ),
        SettingsSection(
          title: Text('other'.tr),
          tiles: [
            SettingsTile(
              title: Text('rating'.tr),
              leading: const Icon(Icons.star),
              onPressed: (context) {
                try {
                  launchUrl(Uri.parse(
                      "market://details?id=com.app.zuludin.during.during"));
                } on PlatformException catch (_) {
                  launchUrl(Uri.parse(
                      "https://play.google.com/store/apps/details?id=com.app.zuludin.during.during"));
                } finally {
                  launchUrl(Uri.parse(
                      "https://play.google.com/store/apps/details?id=com.app.zuludin.during.during"));
                }
              },
            ),
            SettingsTile(
              title: Text('share'.tr),
              leading: const Icon(Icons.share),
              onPressed: (context) {
                Share.share(
                    'https://play.google.com/store/apps/details?id=com.app.zuludin.during.during');
              },
            ),
          ],
        )
      ],
    );
  }
}
