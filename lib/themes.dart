import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppTheme {
  final int id;
  final String logoPath;
  final String Function(AppLocalizations) nameFunction;
  final Color previewColor;
  final ThemeMode themeMode;
  final ThemeData themeData;

  const AppTheme(
      {required this.id,
      required this.logoPath,
      required this.nameFunction,
      required this.previewColor,
      required this.themeMode,
      required this.themeData});
}

class AppThemes {
  static final List<AppTheme> themes = [light(), dark()];
  static const TextStyle _defaultStyle = TextStyle(fontFamily: 'Montserrat', fontFamilyFallback: ['Arial']);

  const AppThemes._();

  static AppTheme light() {
    return AppTheme(
        id: 1,
        logoPath: 'assets/logo/logo_blue.svg',
        nameFunction: (_) => 'Light',
        previewColor: Colors.white,
        themeMode: ThemeMode.light,
        themeData: _buildThemeData(Brightness.light));
  }

  static AppTheme dark() {
    return AppTheme(
        id: 2,
        logoPath: 'assets/logo/logo_light.svg',
        nameFunction: (_) => 'Dark',
        previewColor: const Color(0xFF2B2D31),
        themeMode: ThemeMode.dark,
        themeData: _buildThemeData(Brightness.dark));
  }

  static ThemeData _buildThemeData(Brightness brightness) {
    final ThemeData themeData = ThemeData(brightness: brightness);
    return themeData.copyWith(
        brightness: brightness,
        colorScheme: themeData.colorScheme.copyWith(primary: const Color(0xFF2C03E6)),
        textTheme: themeData.textTheme.copyWith(
          displayLarge: _defaultStyle.copyWith(fontSize: 57, fontWeight: FontWeight.w400),
          displayMedium: _defaultStyle.copyWith(fontSize: 45, fontWeight: FontWeight.w400),
          displaySmall: _defaultStyle.copyWith(fontSize: 36, fontWeight: FontWeight.w400),
          headlineLarge: _defaultStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w400),
          headlineMedium: _defaultStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w400),
          headlineSmall: _defaultStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w400),
          titleLarge: _defaultStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w500),
          titleMedium: _defaultStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          titleSmall: _defaultStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          bodyLarge: _defaultStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          bodyMedium: _defaultStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
          bodySmall: _defaultStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
          labelLarge: _defaultStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
          labelMedium: _defaultStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
          labelSmall: _defaultStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w500),
        ),
        inputDecorationTheme: themeData.inputDecorationTheme.copyWith(border: const OutlineInputBorder()));
  }
}
