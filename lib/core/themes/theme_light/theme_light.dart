import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whats_app/core/themes/theme_light/theme_light_color.dart';

ThemeData lightTheme() {
  return ThemeData(
    fontFamily: "Droid",
    // outdated and has no effect to Tabbar
    primaryColor: ThemeLightColors.primaryLight,
    scaffoldBackgroundColor: ThemeLightColors.scaffoldBackgroundLight,
    dialogBackgroundColor: ThemeLightColors.primaryLight,
    //background stepper
    canvasColor: ThemeLightColors.scaffoldBackgroundLight,
    unselectedWidgetColor: ThemeLightColors.secondaryLight,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    drawerTheme: const DrawerThemeData(
      backgroundColor: ThemeLightColors.primaryLight,
    ),
    //colors app
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      background: ThemeLightColors.primaryLight,
      primary: ThemeLightColors.blueLight,
      secondary: ThemeLightColors.secondaryLight,
      inversePrimary: ThemeLightColors.blackLight,
    ),
    //icon app
    iconTheme: const IconThemeData(
      color: ThemeLightColors.secondaryLight,
    ),
    //app bar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeLightColors.scaffoldBackgroundLight,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: "Droid",
        color: ThemeLightColors.blackLight,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: ThemeLightColors.blackLight),
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    //bottom navigation bar
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0,
      backgroundColor: ThemeLightColors.scaffoldBackgroundLight,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(color: Colors.white, size: 25),
      unselectedIconTheme: IconThemeData(color: Color(0xff8EDFEB), size: 25),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    //text
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w800,
        color: ThemeLightColors.blackLight,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: ThemeLightColors.blackLight,
      ),
      headlineMedium: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: ThemeLightColors.blackLight,
      ),
      headlineSmall: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w400,
        color: ThemeLightColors.blackLight,
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: ThemeLightColors.blackLight,
      ),
      bodyMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300,
        color: ThemeLightColors.blackLight,
      ),
      bodySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: ThemeLightColors.blackLight,
      ),
      labelSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ThemeLightColors.blackLight,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ThemeLightColors.blackLight,
      ),
    ),
    //input decoration
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: ThemeLightColors.blackLight,
        fontSize: 15,
      ),
      alignLabelWithHint: true,
      floatingLabelStyle: TextStyle(
        color: ThemeLightColors.blackLight,
        fontSize: 15,
      ),
      suffixIconColor: ThemeLightColors.blackLight,
      errorStyle: TextStyle(
        color: ThemeLightColors.errorLight,
        fontSize: 15,
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeLightColors.grayLight, width: 3),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeLightColors.grayLight, width: 3),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeLightColors.grayLight, width: 3),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeLightColors.errorLight, width: 3),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeLightColors.errorLight, width: 3),
      ),
    ),
    //elevation button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(1),
        backgroundColor: ThemeLightColors.blueLight,
        foregroundColor: ThemeLightColors.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: ThemeLightColors.primaryLight,
          fontSize: 24,
        ),
      ),
    ),
    //tab bar
    tabBarTheme: const TabBarTheme(
      labelColor: ThemeLightColors.blueLight,
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        color: ThemeLightColors.blueLight,
      ),
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ThemeLightColors.blueLight,
      ),
      indicator: UnderlineTabIndicator(
        // color for indicator (underline)
        borderSide: BorderSide(
          width: 2,
          color: ThemeLightColors.blueLight,
        ),
        //border raduis indicator
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(3),
        ),
      ),
    ),
    //change color indicator
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ThemeLightColors.blackLight,
      selectionColor: ThemeLightColors.grayLight,
      selectionHandleColor: ThemeLightColors.grayLight,
    ),
    //icon button
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.centerRight,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: MaterialStateProperty.resolveWith((states) {
          // If the button is pressed, return size 40, otherwise 20
          return const TextStyle(
            fontSize: 16,
          );
        }),
        iconColor: MaterialStateProperty.resolveWith((states) {
          return ThemeLightColors.blackLight;
        }),
      ),
    ),
    //alert dialog
    dialogTheme: const DialogTheme(
      backgroundColor: ThemeLightColors.scaffoldBackgroundLight,
      actionsPadding: EdgeInsets.all(20),
      alignment: Alignment.center,
      contentTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ThemeLightColors.blackLight,
      ),
      iconColor: ThemeLightColors.secondaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: ThemeLightColors.blackLight,
      ),
    ),
  );
}
