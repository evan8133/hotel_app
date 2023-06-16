import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../core/utils/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const String name = 'settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = true;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('General'),
          tiles: [
            SettingsTile.navigation(
              title: const Text('Abstract settings screen'),
              leading: const Icon(CupertinoIcons.wrench),
              description:
                  const Text('UI created to show plugin\'s possibilities'),
              onPressed: (context) {},
            )
          ],
        ),
        SettingsSection(
          title: const Text('Application'),
          tiles: [
            SettingsTile.switchTile(
              leading: const Icon(Icons.dark_mode_sharp),
              title: const Text('Dark Mode'),
              initialValue: darkMode,
              onToggle: (value) {
                setState(() {
                  darkMode = value;
                });
                final newThemeMode =
                    value ? ThemeModeType.dark : ThemeModeType.light;
                themeProvider.setThemeMode(newThemeMode);
              },
            ),
          ],
        ),
        SettingsSection(
          title: const Text('About'),
          tiles: [
            SettingsTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Terms of Service'),
              onPressed: (context) {},
            ),
            SettingsTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Version'),
              description: const Text('1.0.0'),
              onPressed: (context) {},
            ),
          ],
        ),
      ],
    );
  }
}
