import 'package:during/service/cache_service.dart';
import 'package:during/ui/dashboard/controllers/setting_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingNavigation extends StatefulWidget {
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
      lightTheme: SettingsThemeData(
        settingsListBackground: Colors.white,
      ),
      sections: [
        SettingsSection(
          title: Text('Common'),
          tiles: [
            SettingsTile.switchTile(
              initialValue: showSlider,
              leading: Icon(Icons.credit_card),
              onToggle: (value) {
                _controller.toggleSavingSlider(value);
                setState(() {
                  showSlider = value;
                });
              },
              title: Text('Hide Saving'),
              description: Text('Hide saving slider in home page'),
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
              title: Text('Dark Theme'),
              leading: Icon(Icons.dark_mode),
            ),
            SettingsTile(
              title: Text('Google Drive Backup'),
              leading: Icon(Icons.backup),
            ),
            SettingsTile(
              title: Text('Language'),
              leading: Icon(Icons.language),
            ),
          ],
        ),
        SettingsSection(
          title: Text('Other'),
          tiles: [
            SettingsTile(
              title: Text('Rating'),
              leading: Icon(Icons.star),
            ),
            SettingsTile(
              title: Text('Share'),
              leading: Icon(Icons.share),
            ),
            SettingsTile(
              title: Text('Info'),
              leading: Icon(Icons.info),
            ),
          ],
        )
      ],
    );
  }
}
