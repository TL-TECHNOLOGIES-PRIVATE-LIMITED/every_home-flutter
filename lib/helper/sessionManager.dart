import 'package:every_home_flutter/helper/utils/general_imports.dart';
import 'package:get/get.dart';

class SessionManager extends GetxController {
  static const String isLocation = "isLocation";
  static const String isFetched = "isFetched";
  static const String isUserLogin = "isUserLogin";
  static const String introSlider = "introSlider";
  static const String isDarkTheme = "isDarkTheme";
  static const String appThemeName = "appThemeName";
  static const String keySelectedLanguageId = "selectedLanguageId";
  static const String keySelectedLanguageCode = "selectedLanguageCode";
  static const String keyRecentAddressSearch = "recentAddress";
  static const String keySkipLogin = "keySkipLogin";
  static const String keyUserName = "username";
  static const String keyUserImage = "image";
  static const String keyPhone = "phone";
  static const String keyEmail = "email";
  static const String keyCountryCode = "countryCode";
  static const String keyReferralCode = "referral_code";
  static const String keyUserStatus = "userStatus";
  static const String keyToken = "keyToken";
  static const String keyFCMToken = "keyFCMToken";
  static const String keyIsGrid = "isGrid";
  static const String keyLatitude = "keyLatitude";
  static const String keyLongitude = "keyLongitude";
  static const String keyAddress = "keyAddress";
  static const String keyWalletBalance = "keyWalletBalance";
  static const String keyGuestCartItems = "keyGuestCartItems";
  static const String keyLoginType = "keyLoginType";
  static const String appThemeKey = "AppThemeKey";

  late SharedPreferences prefs;

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  String getData(String key) => prefs.getString(key) ?? "";

  void setData(String key, String value) {
    prefs.setString(key, value);
    update();
  }

  Future<void> setUserData({
    required String name,
    required String email,
    required String profile,
    required String countryCode,
    required String mobile,
    required String referralCode,
    required int status,
    required String token,
    required String balance,
    required String type,
  }) async {
    prefs.setString(keyToken, token);
    setData(keyUserName, name);
    setData(keyUserImage, profile);
    setData(keyEmail, email);
    prefs.setString(keyCountryCode, countryCode);
    prefs.setString(keyPhone, mobile);
    prefs.setString(keyReferralCode, referralCode);
    prefs.setInt(keyUserStatus, status);
    setBoolData(isUserLogin, true);
    prefs.setString(keyWalletBalance, balance);
    prefs.setString(keyLoginType, type);
    update();
  }

  void setDoubleData(String key, double value) {
    prefs.setDouble(key, value);
    update();
  }

  double getDoubleData(String key) => prefs.getDouble(key) ?? 0.0;

  bool getBoolData(String key) => prefs.getBool(key) ?? false;

  void setBoolData(String key, bool value) {
    prefs.setBool(key, value);
    update();
  }

  int getIntData(String key) => prefs.getInt(key) ?? 0;

  void setIntData(String key, int value) {
    prefs.setInt(key, value);
    update();
  }

  bool isUserLoggedIn() => getBoolData(isUserLogin);

  void logoutUser() {
    prefs.clear();
    setBoolData(introSlider, true);
    setBoolData(isUserLogin, false);
    update();
  }

  RxBool isDarkMode = false.obs;

  SessionManager({required this.prefs}) {
    _initializeTheme();
  }

  void _initializeTheme() {
    // Load saved theme preference
    int savedTheme = prefs.getInt(appThemeKey) ?? 1;
    currentTheme.value = savedTheme;
    _updateDarkModeState();
  }

  void _updateDarkModeState() {
    if (currentTheme.value == 1) {
      // System theme
      final window = WidgetsBinding.instance.window;
      isDarkMode.value = window.platformBrightness == Brightness.dark;
    } else {
      // Manual theme selection
      isDarkMode.value = currentTheme.value == 3;
    }
    _updateSystemUI();
    update(); // Notify GetX about the change
  }

  void toggleTheme(int newTheme) {
    if (newTheme == currentTheme.value) return;

    currentTheme.value = newTheme;
    prefs.setInt(appThemeKey, newTheme); // Save to SharedPreferences
    _updateDarkModeState();

    final ThemeMode themeMode = switch (newTheme) {
      1 => ThemeMode.system,
      2 => ThemeMode.light,
      3 => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    Get.changeThemeMode(themeMode);
  }

  void _updateSystemUI() {
    final brightness = isDarkMode.value ? Brightness.dark : Brightness.light;
    final backgroundColor = isDarkMode.value
        ? ColorsRes.darkTheme.scaffoldBackgroundColor
        : ColorsRes.lightTheme.scaffoldBackgroundColor;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      statusBarBrightness: brightness,
      statusBarIconBrightness:
          isDarkMode.value ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: backgroundColor,
      systemNavigationBarIconBrightness:
          isDarkMode.value ? Brightness.light : Brightness.dark,
    ));
  }

  void handleSystemThemeChange() {
    if (currentTheme.value == 1) {
      _updateDarkModeState();
    }
  }

  int getCurrentThemeNo() => currentTheme.value;
  bool darkTheme() => isDarkMode.value;

  RxInt currentTheme = 1.obs; // 1 for system, 2 for light, 3 for dark
}
