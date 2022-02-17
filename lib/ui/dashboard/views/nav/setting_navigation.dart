import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingNavigation extends StatelessWidget {
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
              initialValue: false,
              leading: Icon(Icons.credit_card),
              onToggle: (value) {},
              title: Text('Hide Saving'),
              description: Text('Hide saving slider in home page'),
            ),
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (value) {},
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
