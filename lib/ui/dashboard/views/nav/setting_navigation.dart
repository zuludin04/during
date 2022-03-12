import 'package:during/service/cache_service.dart';
import 'package:during/ui/dashboard/controllers/setting_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

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
          title: const Text('Common'),
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
              title: const Text('Hide Saving'),
              description: const Text('Hide saving slider in home page'),
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
              title: const Text('Dark Theme'),
              leading: const Icon(Icons.dark_mode),
            ),
            SettingsTile(
              title: const Text('Google Drive Backup'),
              leading: const Icon(Icons.backup),
            ),
            SettingsTile(
              title: const Text('Language'),
              leading: const Icon(Icons.language),
            ),
          ],
        ),
        SettingsSection(
          title: const Text('Other'),
          tiles: [
            SettingsTile(
              title: const Text('Rating'),
              leading: const Icon(Icons.star),
            ),
            SettingsTile(
              title: const Text('Share'),
              leading: const Icon(Icons.share),
            ),
            SettingsTile(
              title: const Text('Info'),
              leading: const Icon(Icons.info),
            ),
          ],
        )
      ],
    );
  }
}
