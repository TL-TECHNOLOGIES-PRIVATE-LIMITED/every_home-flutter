import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const String themeKey = "isDarkMode";
  late SharedPreferences _prefs;

  // Observable for theme mode
  RxBool isDarkMode = false.obs;

  @override
  void onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    isDarkMode.value = _prefs.getBool(themeKey) ?? false;
  }

  // Function to toggle theme
  void toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    await _prefs.setBool(themeKey, isDarkMode.value);
  }
}
