import 'package:financrr_frontend/pages/auth/server_info_page.dart';
import 'package:financrr_frontend/pages/core/settings/theme_settings_page.dart';
import 'package:financrr_frontend/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:restrr/restrr.dart';

import '../../router.dart';

class SettingsPage extends StatefulWidget {
  static const PagePathBuilder pagePath = PagePathBuilder('/@me/settings');

  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final Restrr _api = context.api!;

  late final List<ListTile> _tiles = [
    ListTile(
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(color: context.theme.primaryColor.withOpacity(.5), shape: BoxShape.circle),
        child: Center(child: Text(_api.selfUser.effectiveDisplayName.substring(0, 2))),
      ),
      title: Text(_api.selfUser.effectiveDisplayName),
      subtitle: const Text('Display Name, E-Mail, Password'),
    ),
    ListTile(
      onTap: () {
        context.pushPath(ThemeSettingsPage.pagePath.build());
      },
      leading: const Icon(Icons.brightness_4_outlined),
      title: const Text('Theme'),
      subtitle: const Text('Toggle between light and dark mode'),
    ),
    const ListTile(
      leading: Icon(Icons.language),
      title: Text('Language'),
      subtitle: Text('Change the language of the app'),
    ),
    ListTile(
      onTap: () async {
        await _api.logout();
        context.authNotifier.setApi(null);
        context.goPath(ServerInfoPage.pagePath.build());
      },
      leading: const Icon(Icons.logout),
      title: const Text('Logout'),
      subtitle: const Text('Log out of your account'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
      itemCount: _tiles.length,
      itemBuilder: (_, index) {
        if (index == 0) {
          return Padding(padding: const EdgeInsets.only(top: 10), child: _tiles[index]);
        }
        return _tiles[index];
      },
      separatorBuilder: (_, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: index == 0 ? const Divider() : null,
      ),
    ));
  }
}
