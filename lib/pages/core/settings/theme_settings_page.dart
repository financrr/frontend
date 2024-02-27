import 'package:financrr_frontend/main.dart';
import 'package:financrr_frontend/pages/auth/server_info_page.dart';
import 'package:financrr_frontend/themes.dart';
import 'package:financrr_frontend/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:restrr/restrr.dart';

import '../../../layout/adaptive_scaffold.dart';
import '../../../router.dart';
import '../settings_page.dart';

class ThemeSettingsPage extends StatefulWidget {
  static const PagePathBuilder pagePath = PagePathBuilder('/@me/settings/theme');

  const ThemeSettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  late final Restrr _api = context.api!;
  late AppTheme _selectedTheme = context.appTheme;
  late bool _useSystemTheme = FinancrrApp.of(context).themeMode == ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      resizeToAvoidBottomInset: false,
      verticalBuilder: (_, __, size) => SafeArea(child: _buildVerticalLayout(size)),
    );
  }

  Widget _buildVerticalLayout(Size size) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Theme'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                onTap: () {},
                title: const Text('Selected Theme'),
                trailing: Text(context.appTheme.nameFunction(context.locale)),
              ),
            ),
            ListTile(
                title: const Text('Use System Theme'),
                trailing: Switch(
                  value: _useSystemTheme,
                  onChanged: (value) {
                    FinancrrApp.of(context).changeAppTheme(theme: _selectedTheme, system: value);
                    setState(() => _useSystemTheme = value);
                  },
                )),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildThemePreview(AppThemes.light()),
                  _buildThemePreview(AppThemes.dark()),
                  _buildThemePreview(AppThemes.amoledDark()),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildThemePreview(AppTheme theme) {
    return GestureDetector(
      onTap: () {
        FinancrrApp.of(context).changeAppTheme(theme: theme);
        setState(() {
          _selectedTheme = theme;
          _useSystemTheme = false;
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: theme.previewColor, shape: BoxShape.circle, border: Border.all(color: Colors.grey[400]!)),
        child: theme.id == _selectedTheme.id
            ? Center(child: Icon(Icons.check, color: context.lightMode ? Colors.black : Colors.white))
            : null,
      ),
    );
  }
}
