import 'package:during/routes/app_pages.dart';
import 'package:during/service/cache_service.dart';
import 'package:during/ui/dashboard/controllers/setting_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingNavigation extends StatefulWidget {
  const SettingNavigation({Key? key}) : super(key: key);

  @override
  State<SettingNavigation> createState() => _SettingNavigationState();
}

class _SettingNavigationState extends State<SettingNavigation> {
  final SettingNavigationController _controller = Get.find();

  bool showSlider = CacheService.to.showSlider;
  bool darkMode = CacheService.to.darkMode;

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      lightTheme: const SettingsThemeData(
        settingsListBackground: Colors.white,
      ),
      sections: [
        SettingsSection(
          title: Text('common'.tr),
          tiles: [
            SettingsTile.switchTile(
              initialValue: showSlider,
              leading: const Icon(Icons.credit_card),
              onToggle: (value) {
                _controller.toggleSavingSlider(value);
                setState(() {
                  showSlider = value;
                });
              },
              title: Text('hide_saving'.tr),
              description: Text('hide_saving_desc'.tr),
            ),
            SettingsTile.switchTile(
              initialValue: darkMode,
              onToggle: (value) {
                _controller.toggleDarkTheme(value);
                Get.isDarkMode
                    ? Get.changeTheme(ThemeData.light())
                    : Get.changeTheme(ThemeData.dark());
                setState(() {
                  darkMode = value;
                });
              },
              title: Text('dark_theme'.tr),
              leading: const Icon(Icons.dark_mode),
            ),
            SettingsTile(
              title: Text('google_backup'.tr),
              leading: const Icon(Icons.backup),
            ),
            SettingsTile(
              title: Text('language'.tr),
              leading: const Icon(Icons.language),
              onPressed: (context) => Get.toNamed(RoutePath.language),
            ),
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
                  launch("market://details?id=com.app.zuludin.during.during");
                } on PlatformException catch (_) {
                  launch(
                      "https://play.google.com/store/apps/details?id=com.app.zuludin.during.during");
                } finally {
                  launch(
                      "https://play.google.com/store/apps/details?id=com.app.zuludin.during.during");
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
