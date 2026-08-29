import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flexiJobs/core/theming/palette.dart';

class AppTheme {
  AppTheme._();

  // *****************
  //AppBar
  // *****************
  static const AppBarTheme appBarTHemeLight = AppBarTheme(elevation: 0.0);

  static AppBarTheme appBarTHemeDark = AppBarTheme(
    elevation: 0.0,
    // surfaceTintColor: Colors.white,
    foregroundColor: Palette.white,
    // color: Palette.backgroundColorDark,
    backgroundColor: Palette.backgroundColorDark,
    iconTheme: IconThemeData(color: Palette.white),
    titleTextStyle: TextStyle(
      color: Palette.white,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    ),
  );

  // *****************
  // static colors
  // *****************

  static const Color _lightTextColorPrimary = Palette.black;
  static const Color _darkTextColorPrimary = Palette.white;

  static const TextStyle _lightHeadingText = TextStyle(
    color: _lightTextColorPrimary,
    fontFamily: "Montserrat",
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _lightBodyText = TextStyle(
    color: _lightTextColorPrimary,
    fontFamily: "Montserrat",
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  // *****************
  //Buttons
  // *****************
  static final ElevatedButtonThemeData elevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );

  static final OutlinedButtonThemeData outlinedButtonTheme =
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Palette.primaryColor,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          side: const BorderSide(color: Palette.primaryColor),
        ),
      );

  //
  // *****************
  // Text Style - dark
  // *****************
  static final TextStyle _darkThemeHeadingTextStyle = _lightHeadingText
      .copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyeTextStyle = _lightBodyText.copyWith(
    color: _darkTextColorPrimary,
  );

  // *****************
  // Theme light/dark
  // *****************

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    elevatedButtonTheme: elevatedButtonTheme,
    scaffoldBackgroundColor: Palette.white,
    brightness: Brightness.light,
    appBarTheme: appBarTHemeLight,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Palette.grey_A5A5A5,
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
      ),
      fillColor: Palette.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: Palette.grey_E6E6E6),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: Palette.grey_E6E6E6),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: Palette.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: Palette.darkRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: Palette.darkRed),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: const BorderSide(color: Palette.grey_E6E6E6),
      ),
    ),
    primaryColor: Palette.primaryColor,
    secondaryHeaderColor: Palette.black,
    fontFamily: "Montserrat",

    cardColor: Palette.white,
    primaryColorDark: Palette.lightBlack,
    shadowColor: Colors.black,
    disabledColor: Colors.grey,
    colorScheme: const ColorScheme.light(primary: Palette.primaryColor),
    //colorSchemeSeed: null,
    // dialogBackgroundColor: Colors.white,
    // dividerColor: Colors.grey,
    // focusColor: Colors.blue,
    // highlightColor: Colors.blue[200],
    // hintColor: Colors.grey,
    // hoverColor: Colors.grey[200],
    // indicatorColor: Colors.blue,
    // primaryColorLight: Colors.blue[200],
    // primarySwatch: Colors.blue,
    // splashColor: Colors.blue[200],
    // unselectedWidgetColor: Colors.grey,
    // fontFamilyFallback: ['Arial', 'Helvetica'],
    // iconTheme: const IconThemeData(color: Colors.black),
    // primaryIconTheme: const IconThemeData(color: Colors.blue),
    // primaryTextTheme: const TextTheme(),
    // actionIconTheme: const ActionIconThemeData(),
    // badgeTheme: const BadgeThemeData(),
    // bannerTheme: const MaterialBannerThemeData(),
    // bottomAppBarTheme: const BottomAppBarTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Palette.white,
      unselectedItemColor: Palette.grey_A5A5A5,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Palette.primaryColor,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        fontFamily: "Montserrat",
        height: 1.2,
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        fontFamily: "Montserrat",
        height: 1.2,
      ),
    ),
    // bottomSheetTheme: const BottomSheetThemeData(),
    // buttonBarTheme: const ButtonBarThemeData(),
    // buttonTheme: const ButtonThemeData(),
    // cardTheme: const CardTheme(),
    // checkboxTheme: const CheckboxThemeData(),
    // chipTheme: const ChipThemeData(),
    // dataTableTheme: const DataTableThemeData(),
    // datePickerTheme: const DatePickerThemeData(),
    // dialogTheme: const DialogTheme(),
    // dividerTheme: const DividerThemeData(),
    // drawerTheme: const DrawerThemeData(),
    // dropdownMenuTheme: const DropdownMenuThemeData(),
    // elevatedButtonTheme: const ElevatedButtonThemeData(),
    // expansionTileTheme: const ExpansionTileThemeData(),
    // filledButtonTheme: const FilledButtonThemeData(),
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    // iconButtonTheme: const IconButtonThemeData(),
    // listTileTheme: const ListTileThemeData(),
    // menuBarTheme: const MenuBarThemeData(),
    // menuButtonTheme: const MenuButtonThemeData(),
    // menuTheme: const MenuThemeData(),
    // navigationBarTheme: const NavigationBarThemeData(),
    // navigationDrawerTheme: const NavigationDrawerThemeData(),
    // navigationRailTheme: const NavigationRailThemeData(),
    // outlinedButtonTheme: const OutlinedButtonThemeData(),
    // popupMenuTheme: const PopupMenuThemeData(),
    // progressIndicatorTheme: const ProgressIndicatorThemeData(),
    // radioTheme: const RadioThemeData(),
    // searchBarTheme: const SearchBarThemeData(),
    // searchViewTheme: const SearchViewThemeData(),
    // segmentedButtonTheme: const SegmentedButtonThemeData(),
    // sliderTheme: const SliderThemeData(),
    // snackBarTheme: const SnackBarThemeData(),
    // switchTheme: const SwitchThemeData(),
    // tabBarTheme: const TabBarTheme(),
    // textButtonTheme: const TextButtonThemeData(),
    // textSelectionTheme: const TextSelectionThemeData(),
    // timePickerTheme: const TimePickerThemeData(),
    // toggleButtonsTheme: const ToggleButtonsThemeData(),
    // tooltipTheme: const TooltipThemeData(),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Palette.black,
    brightness: Brightness.dark,
    appBarTheme: appBarTHemeDark,
    primaryColor: Palette.white,
    secondaryHeaderColor: Palette.white,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Palette.semiLightBlack,
      filled: true,
      hintStyle: TextStyle(
        //   color: Palette.white,
        fontSize: 16.sp,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Palette.darkRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Palette.darkRed),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
    fontFamily: "Montserrat",
    cardColor: Palette.semiLightBlack,
    colorScheme: const ColorScheme.dark(primary: Palette.primaryColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Palette.semiLightBlack,
      unselectedItemColor: Palette.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Palette.primaryColor,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        fontFamily: "Montserrat",
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        fontFamily: "Montserrat",
      ),
    ),
  );

  // *****************
  // Icon
  // *****************

  // *****************
  // Text Style - light
  // *****************

  static Color? inDarkMode(BuildContext context, {Color? light, Color? dark}) {
    if (Theme.of(context).brightness == Brightness.dark) return dark;
    return light;
  }

  static bool isDarkMode(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return true;
    }
    return false;
  }
}
