import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme_dark_color.dart';

ThemeData darkTheme() {
  return ThemeData(
    fontFamily: "Droid",
    // outdated and has no effect to Tabbar
    scaffoldBackgroundColor: ThemeDarkColors.scafoldBackgroundDark,
    primaryColor: ThemeDarkColors.primaryColorDark,
    canvasColor: ThemeDarkColors.scafoldBackgroundDark,
    unselectedWidgetColor: ThemeDarkColors.scafoldBackgroundDark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    drawerTheme: const DrawerThemeData(
      backgroundColor: ThemeDarkColors.primaryColorDark,
    ),
    //colors app
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: ThemeDarkColors.tabColor,
      secondary: ThemeDarkColors.secandaryColorDark,
      inversePrimary: ThemeDarkColors.whitDark,
      error: ThemeDarkColors.errorDark,
    ),
    //icon app
    iconTheme: const IconThemeData(
      color: ThemeDarkColors.secandaryColorDark,
    ),
    //app bar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeDarkColors.scafoldBackgroundDark,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: "Droid",
        color: ThemeDarkColors.whitDark,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: ThemeDarkColors.whitDark),
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    //bottom navigation bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ThemeDarkColors.scafoldBackgroundDark,
      selectedIconTheme: const IconThemeData(color: ThemeDarkColors.whitDark),
      unselectedIconTheme: IconThemeData(
        color: ThemeDarkColors.grayDark.withOpacity(0.5),
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
      enableFeedback: false,
      type: BottomNavigationBarType.fixed,
    ),
    //text
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w800,
        color: ThemeDarkColors.whitDark,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: ThemeDarkColors.whitDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: ThemeDarkColors.whitDark,
      ),
      headlineSmall: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w400,
        color: ThemeDarkColors.whitDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: ThemeDarkColors.whitDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300,
        color: ThemeDarkColors.whitDark,
      ),
      bodySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: ThemeDarkColors.whitDark,
      ),
      labelSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ThemeDarkColors.whitDark,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ThemeDarkColors.whitDark,
      ),
      titleSmall: TextStyle(
        fontSize: 15,
        color: ThemeDarkColors.whitDark,
      ),
    ),
    //input decoration
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: ThemeDarkColors.whitDark,
        fontSize: 15,
      ),
      alignLabelWithHint: true,
      floatingLabelStyle: TextStyle(
        color: ThemeDarkColors.whitDark,
        fontSize: 15,
      ),
      iconColor: ThemeDarkColors.whitDark,
      suffixIconColor: ThemeDarkColors.whitDark,
      prefixIconColor: ThemeDarkColors.whitDark,
      prefixStyle: TextStyle(color: Colors.white),
      errorStyle: TextStyle(
        color: ThemeDarkColors.errorDark,
        fontSize: 15,
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeDarkColors.grayDark, width: 3),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeDarkColors.grayDark, width: 3),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeDarkColors.grayDark, width: 3),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeDarkColors.errorDark, width: 3),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeDarkColors.errorDark, width: 3),
      ),
    ),
    //elevation button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(1),
        backgroundColor: ThemeDarkColors.tabColor,
        foregroundColor: ThemeDarkColors.scafoldBackgroundDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        textStyle: const TextStyle(fontSize: 20),
      ),
    ),
    //tab bar
    tabBarTheme: const TabBarTheme(
      labelColor: ThemeDarkColors.whitDark,
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: ThemeDarkColors.whitDark,
      ),
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ThemeDarkColors.whitDark,
      ),
      indicator: UnderlineTabIndicator(
        // color for indicator (underline)
        borderSide: BorderSide(
          width: 2,
          color: ThemeDarkColors.whitDark,
        ),
        //border raduis indicator
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(3),
        ),
      ),
    ),
    //change color indicator
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ThemeDarkColors.grayDark,
      selectionColor: ThemeDarkColors.grayDark,
      selectionHandleColor: ThemeDarkColors.grayDark,
    ),
    //icon button
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith((states) {
          // If the button is pressed, return size 40, otherwise 20
          return const TextStyle(
            fontSize: 20,
            color: ThemeDarkColors.whitDark,
            fontWeight: FontWeight.bold,
          );
        }),
        iconColor: MaterialStateProperty.resolveWith((states) {
          return ThemeDarkColors.whitDark;
        }),
      ),
    ),
    //alert dialog
    dialogTheme: const DialogTheme(
      backgroundColor: ThemeDarkColors.primaryColorDark,
      actionsPadding: EdgeInsets.all(20),
      alignment: Alignment.center,
      contentTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: ThemeDarkColors.whitDark,
      ),
      iconColor: ThemeDarkColors.secandaryColorDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: ThemeDarkColors.whitDark,
      ),
    ),
    //text buttton
  );
}
