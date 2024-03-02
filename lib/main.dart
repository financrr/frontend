import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:financrr_frontend/data/host_repository.dart';
import 'package:financrr_frontend/data/repositories.dart';
import 'package:financrr_frontend/pages/core/dashboard_page.dart';
import 'package:financrr_frontend/router.dart';
import 'package:financrr_frontend/themes.dart';
import 'package:financrr_frontend/util/input_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:restrr/restrr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'data/theme_repository.dart';

void main() async {
  usePathUrlStrategy();
  SharedPreferences.setPrefix('financrr.');
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  const FlutterSecureStorage storage = FlutterSecureStorage();
  await Repositories.init(storage, preferences);
  final EffectiveThemePreferences themePreferences = await ThemeService.getOrInsertEffective();
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('de', 'DE')],
      path: 'assets/l10n',
      fallbackLocale: const Locale('en', 'US'),
      child: FinancrrApp(themePreferences: themePreferences)));
}

class FinancrrApp extends StatefulWidget {
  final EffectiveThemePreferences themePreferences;

  const FinancrrApp({super.key, required this.themePreferences});

  @override
  State<FinancrrApp> createState() => FinancrrAppState();

  static FinancrrAppState of(BuildContext context) => context.findAncestorStateOfType<FinancrrAppState>()!;
}

class FinancrrAppState extends State<FinancrrApp> {
  AppTheme _activeLightTheme = AppThemes.light();
  AppTheme _activeDarkTheme = AppThemes.dark();
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  AppTheme get activeLightTheme => _activeLightTheme;
  AppTheme get activeDarkTheme => _activeDarkTheme;

  @override
  void initState() {
    super.initState();
    _activeLightTheme = widget.themePreferences.currentLightTheme;
    _activeDarkTheme = widget.themePreferences.currentDarkTheme;
    _themeMode = widget.themePreferences.themeMode;
    // try to fetch user (user may still be logged in)
    // TODO: this doesn't seem to work. wait until backend introduces session ids/tokens
    final String hostUrl = HostService.get().hostUrl;
    if (hostUrl.isNotEmpty && InputValidators.url(context, hostUrl) == null) {
      (RestrrBuilder.savedSession(uri: Uri.parse(hostUrl))..options = const RestrrOptions(isWeb: kIsWeb))
          .on<ReadyEvent>(ReadyEvent, (event) => event.api.retrieveAllCurrencies())
          .create()
          .then((response) {
        if (response.hasData) {
          context.authNotifier.setApi(response.data);
          context.pushPath(DashboardPage.pagePath.build());
        }
      });
    }

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthenticationNotifier(),
      child: MaterialApp.router(
          onGenerateTitle: (ctx) => 'brand_name'.tr(),
          routerConfig: AppRouter.goRouter,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: _activeLightTheme.themeData,
          darkTheme: _activeDarkTheme.themeData,
          themeMode: _themeMode),
    );
  }

  /// Gets the currently active [AppTheme].
  AppTheme getAppTheme() {
    if (_themeMode == ThemeMode.light) {
      return _activeLightTheme;
    }
    if (_themeMode == ThemeMode.dark) {
      return _activeDarkTheme;
    }
    return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.light
        ? _activeLightTheme
        : _activeDarkTheme;
  }

  void changeAppTheme({required AppTheme theme, bool system = false}) {
    setState(() {
      if (theme.themeMode == ThemeMode.light) {
        _activeLightTheme = theme;
      }
      if (theme.themeMode == ThemeMode.dark) {
        _activeDarkTheme = theme;
      }
      _themeMode = system ? ThemeMode.system : theme.themeMode;
      ThemeService.setThemePreferences(_activeLightTheme, _activeDarkTheme, _themeMode);
    });
  }
}

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
