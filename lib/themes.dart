import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppTheme {
  final int id;
  final String Function(AppLocalizations) name;
  final Color previewColor;
  final ThemeMode themeMode;
  final ThemeData themeData;

  const AppTheme(
      {required this.id,
        required this.name,
        required this.previewColor,
        required this.themeMode,
        required this.themeData});
}

class AppThemes {
  static final List<AppTheme> themes = [light(), dark()];
  static const TextStyle _defaultStyle = TextStyle(fontFamily: 'Montserrat', fontFamilyFallback: ['Arial']);

  const AppThemes._();

  static AppTheme light() {
    final TextStyle defaultLightStyle = _defaultStyle.copyWith(color: Colors.black);
    return AppTheme(
        id: 1,
        name: (_) => 'Hell',
        previewColor: Colors.white,
        themeMode: ThemeMode.light,
        themeData: ThemeData(
            extensions: const [
              FinancrrTheme(logoPath: 'assets/images/logo/banner_dark.svg')
            ],
            scaffoldBackgroundColor: Colors.white,
            brightness: Brightness.light,
            colorScheme: ThemeData()
                .colorScheme
                .copyWith(primary: const Color(0xFF266EF1), secondary: const Color(0xFF0235D2), brightness: Brightness.light),
            textTheme: ThemeData().textTheme.copyWith(
              displayLarge: defaultLightStyle.copyWith(fontSize: 57, fontWeight: FontWeight.w400),
              displayMedium: defaultLightStyle.copyWith(fontSize: 45, fontWeight: FontWeight.w400),
              displaySmall: defaultLightStyle.copyWith(fontSize: 36, fontWeight: FontWeight.w400),
              headlineLarge: defaultLightStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w400),
              headlineMedium: defaultLightStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w400),
              headlineSmall: defaultLightStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w400),
              titleLarge: defaultLightStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w500),
              titleMedium: defaultLightStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
              titleSmall: defaultLightStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
              bodyLarge: defaultLightStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
              bodyMedium: defaultLightStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
              bodySmall: defaultLightStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              labelLarge: defaultLightStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
              labelMedium: defaultLightStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
              labelSmall: defaultLightStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w500),
            ),
            drawerTheme: ThemeData().drawerTheme.copyWith(backgroundColor: Colors.white)));
  }

  static AppTheme dark() {
    final TextStyle defaultDarkStyle = _defaultStyle.copyWith(color: Colors.white);
    return AppTheme(
        id: 2,
        name: (_) => 'Dunkel',
        previewColor: const Color(0xFF2B2D31),
        themeMode: ThemeMode.dark,
        themeData: ThemeData(
            extensions: const [
              FinancrrTheme(logoPath: 'assets/images/logo/banner_light.svg')
            ],
            scaffoldBackgroundColor: const Color(0xFF2B2D31),
            brightness: Brightness.dark,
            colorScheme: ThemeData().colorScheme.copyWith(
              primary: const Color(0xFF407BF8),
              secondary: const Color(0xFF2267E7),
              brightness: Brightness.dark,
            ),
            textTheme: ThemeData().textTheme.copyWith(
              displayLarge: defaultDarkStyle.copyWith(fontSize: 57, fontWeight: FontWeight.w400),
              displayMedium: defaultDarkStyle.copyWith(fontSize: 45, fontWeight: FontWeight.w400),
              displaySmall: defaultDarkStyle.copyWith(fontSize: 36, fontWeight: FontWeight.w400),
              headlineLarge: defaultDarkStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w400),
              headlineMedium: defaultDarkStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w400),
              headlineSmall: defaultDarkStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w400),
              titleLarge: defaultDarkStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w500),
              titleMedium: defaultDarkStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
              titleSmall: defaultDarkStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
              bodyLarge: defaultDarkStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
              bodyMedium: defaultDarkStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
              bodySmall: defaultDarkStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              labelLarge: defaultDarkStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
              labelMedium: defaultDarkStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
              labelSmall: defaultDarkStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w500),
            ),
            drawerTheme: ThemeData().drawerTheme.copyWith(backgroundColor: const Color(0xFF2B2D31))));
  }
}

@immutable
class FinancrrTheme extends ThemeExtension<FinancrrTheme> {
  /// The path for this themes' logo.
  final String? logoPath;

  const FinancrrTheme({required this.logoPath});

  @override
  ThemeExtension<FinancrrTheme> copyWith({String? logoPath}) {
    return FinancrrTheme(logoPath: logoPath ?? this.logoPath);
  }

  @override
  ThemeExtension<FinancrrTheme> lerp(covariant ThemeExtension<FinancrrTheme>? other, double t) {
    if (other is! FinancrrTheme) {
      return this;
    }
    return FinancrrTheme(logoPath: logoPath);
  }
}