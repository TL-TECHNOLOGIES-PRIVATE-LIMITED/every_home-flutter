import 'package:every_home_flutter/helper/utils/general_imports.dart';

class ColorsRes {
  static MaterialColor appColor = const MaterialColor(
    0xFF9A7329,
    <int, Color>{
      50: Color(0xFF9A7329),
      100: Color(0xFF9A7329),
      200: Color(0xFF9A7329),
      300: Color(0xFF9A7329),
      400: Color(0xFF9A7329),
      500: Color(0xFF9A7329),
      600: Color(0xFF9A7329),
      700: Color(0xFF9A7329),
      800: Color(0xFF9A7329),
      900: Color(0xFF9A7329),
    },
  );

  static MaterialColor darkAppColor = const MaterialColor(
    0xFFD6AC51,
    <int, Color>{
      50: Color(0xFFD6AC51),
      100: Color(0xFFD6AC51),
      200: Color(0xFFD6AC51),
      300: Color(0xFFD6AC51),
      400: Color(0xFFD6AC51),
      500: Color(0xFFD6AC51),
      600: Color(0xFFD6AC51),
      700: Color(0xFFD6AC51),
      800: Color(0xFFD6AC51),
      900: Color(0xFFD6AC51),
    },
  );

  static Color appColorLight = const Color(0xFF9A7329);
  static Color appColorLightHalfTransparent = const Color(0x262E3593);
  static Color appColorDark = const Color(0xFFD6AC51);

  static Color defaultPageInnerCircle = const Color(0x1A999999);
  static Color defaultPageOuterCircle = const Color(0x0d999999);

  static Color mainTextColor = const Color(0xde000000);

  ///[mainTextColor] do not change the main color change only [mainTextColorLight] and [mainTextColorDark] color only
  static Color mainTextColorLight = const Color(0xff121212);
  static Color mainTextColorDark = const Color(0xffFAFAFA);

  static Color subTitleMainTextColor = const Color(0x94000000);

  ///[subtitleTextColorLight] do not change the main color change only [subTitleTextColorDark] and [subTitleTextColorLight] color only
  static Color subTitleTextColorLight = const Color(0xff555555);
  static Color subTitleTextColorDark = const Color(0xffAAAAAA);

  static Color mainIconColor = Colors.white;

  static Color bgColorLight = const Color(0xfffafafa);
  static Color bgColorDark = const Color(0xff121212);

  static Color cardColorLight = const Color(0xffFEFEFE);
  static Color cardColorDark = const Color(0xff202934);

  static Color grey = Colors.grey;
  static Color lightGrey = const Color(0xffb8babb);
  static Color appColorWhite = Colors.white;
  static Color appColorBlack = Colors.black;
  static Color appColorRed = const Color(0xffF52C45);
  static Color appColorGreen = Colors.green;

  static Color greyBox = const Color(0x0a000000);
  static Color lightGreyBox = const Color.fromARGB(9, 213, 212, 212);

  //It will be same for both theme
  static Color shimmerBaseColor = Colors.white;
  static Color shimmerHighlightColor = Colors.white;
  static Color shimmerContentColor = Colors.white;

  //Dark theme shimmer color
  static Color shimmerBaseColorDark = Colors.grey.withOpacity(0.05);
  static Color shimmerHighlightColorDark = Colors.grey.withOpacity(0.005);
  static Color shimmerContentColorDark = Colors.black;

  //Light theme shimmer color
  static Color shimmerBaseColorLight = Colors.black.withOpacity(0.05);
  static Color shimmerHighlightColorLight = Colors.black.withOpacity(0.005);
  static Color shimmerContentColorLight = Colors.white;

  static Color activeRatingColor = const Color(0xffF4CD32);
  static Color deActiveRatingColor = const Color(0xffAEAEAE);

  static ThemeData lightTheme = ThemeData(
    primaryColor: appColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: bgColorLight,
    cardColor: cardColorLight,
    iconTheme: IconThemeData(
      color: grey,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: grey,
      iconTheme: IconThemeData(
        color: grey,
      ),
    ),
    colorScheme:
        ColorScheme.fromSwatch(primarySwatch: ColorsRes.appColor).copyWith(
      surface: bgColorLight,
      brightness: Brightness.light,
    ),
    cardTheme: CardTheme(
      color: mainTextColor,
      surfaceTintColor: mainTextColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: darkAppColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgColorDark,
    cardColor: cardColorDark,
    iconTheme: IconThemeData(
      color: grey,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: grey,
      iconTheme: IconThemeData(
        color: grey,
      ),
    ),
    colorScheme:
        ColorScheme.fromSwatch(primarySwatch: ColorsRes.darkAppColor).copyWith(
      surface: bgColorDark,
      brightness: Brightness.dark,
    ),
    cardTheme: CardTheme(
      color: mainTextColor,
      surfaceTintColor: mainTextColor,
    ),
  );

  static ThemeData setAppTheme() {
    String theme = Constant.session.getData(SessionManager.appThemeName);
    bool isDarkTheme = Constant.session.getBoolData(SessionManager.isDarkTheme);

    bool isDark = false;
    if (theme == Constant.themeList[2]) {
      isDark = true;
    } else if (theme == Constant.themeList[1]) {
      isDark = false;
    } else if (theme == "" || theme == Constant.themeList[0]) {
      var brightness = PlatformDispatcher.instance.platformBrightness;
      isDark = brightness == Brightness.dark;

      if (theme == "") {
        Constant.session
            .setData(SessionManager.appThemeName, Constant.themeList[0]);
      }
    }

    if (isDark) {
      if (!isDarkTheme) {
        Constant.session.setBoolData(SessionManager.isDarkTheme, false);
      }
      mainTextColor = mainTextColorDark;
      subTitleMainTextColor = subTitleTextColorDark;

      shimmerBaseColor = shimmerBaseColorDark;
      shimmerHighlightColor = shimmerHighlightColorDark;
      shimmerContentColor = shimmerContentColorDark;
      return darkTheme;
    } else {
      if (isDarkTheme) {
        Constant.session.setBoolData(SessionManager.isDarkTheme, true);
      }
      mainTextColor = mainTextColorLight;
      subTitleMainTextColor = subTitleTextColorLight;

      shimmerBaseColor = shimmerBaseColorLight;
      shimmerHighlightColor = shimmerHighlightColorLight;
      shimmerContentColor = shimmerContentColorLight;
      return lightTheme;
    }
  }
}
