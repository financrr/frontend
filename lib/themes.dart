import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final int id;
  final String logoPath;
  final String name;
  final Color previewColor;
  final ThemeMode themeMode;
  final ThemeData themeData;

  const AppTheme(
      {required this.id,
      required this.logoPath,
      required this.name,
      required this.previewColor,
      required this.themeMode,
      required this.themeData});
}

class AppThemes {
  static const String _fontFamily = 'Montserrat';
  static final List<AppTheme> themes = [light(), dark(), midnight()];

  const AppThemes._();

  static AppTheme light() {
    return AppTheme(
        id: 1,
        logoPath: 'assets/logo/logo_light.svg',
        name: 'theme_light'.tr(),
        previewColor: Colors.white,
        themeMode: ThemeMode.light,
        themeData: _buildThemeData(Brightness.light, const Color(0xFF2C03E6), const Color(0xFFFFFFFF)));
  }

  static AppTheme dark() {
    const Color backgroundColor = Color(0xFF111111);
    return AppTheme(
        id: 2,
        logoPath: 'assets/logo/logo_light.svg',
        name: 'theme_dark'.tr(),
        previewColor: backgroundColor,
        themeMode: ThemeMode.dark,
        themeData: _buildThemeData(Brightness.dark, const Color(0xFF4B87FF), backgroundColor));
  }

  static AppTheme midnight() {
    const Color backgroundColor = Color(0xFF000000);
    return AppTheme(
        id: 3,
        logoPath: 'assets/logo/logo_light.svg',
        name: 'theme_midnight'.tr(),
        previewColor: backgroundColor,
        themeMode: ThemeMode.dark,
        themeData: _buildThemeData(Brightness.dark, const Color(0xFF4B87FF), backgroundColor));
  }

  static ThemeData _buildThemeData(Brightness brightness, Color primaryColor, Color backgroundColor) {
    final ThemeData base = ThemeData(
      chipTheme: const ChipThemeData(
        side: BorderSide.none,
      ),
      sliderTheme: const SliderThemeData(
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
        trackHeight: 2.0,
      ),
    );
    final TextTheme textTheme = TextTheme(
      displayLarge: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      displayMedium: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      titleSmall: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: const TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
      ),
    );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      hintColor: Colors.grey[600],
      fontFamily: _fontFamily,
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: const TextStyle(
          fontFamily: _fontFamily,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.grey[900],
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: brightness == Brightness.dark ? Colors.white : Colors.black,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
        backgroundColor: brightness == Brightness.dark ? Colors.black.withOpacity(.1) : backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: backgroundColor,
        scrimColor: Colors.white.withOpacity(0.1),
      ),
      textTheme: textTheme,
      cardColor: Colors.grey[900],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
        ),
      ),
      chipTheme: base.chipTheme,
      sliderTheme: base.sliderTheme,
      popupMenuTheme: const PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: primaryColor.withOpacity(brightness == Brightness.dark ? 0.4 : 0.15),
        iconTheme: MaterialStatePropertyAll(
          IconThemeData(color: Colors.grey[brightness == Brightness.dark ? 500 : 700]),
        ),
        backgroundColor: brightness == Brightness.dark ? Colors.black.withOpacity(.1) : null,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: MaterialStatePropertyAll(
          TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey[brightness == Brightness.dark ? 300 : 800],
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        indicatorColor: primaryColor.withOpacity(brightness == Brightness.dark ? 0.4 : 0.15),
        selectedIconTheme: IconThemeData(color: Colors.grey[brightness == Brightness.dark ? 500 : 700]),
        backgroundColor: brightness == Brightness.dark ? Colors.black.withOpacity(.1) : null,
        selectedLabelTextStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey[brightness == Brightness.dark ? 300 : 800],
        ),
        unselectedLabelTextStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.grey[brightness == Brightness.dark ? 200 : 700],
        ),
      ),
      dialogTheme: const DialogTheme(
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        floatingLabelStyle: textTheme.bodyMedium?.copyWith(color: primaryColor, fontWeight: FontWeight.w600),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        border: const OutlineInputBorder(),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(primaryColor),
        trackColor: MaterialStatePropertyAll(primaryColor.withOpacity(0.5)),
        trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
      ),
    );
  }
}
