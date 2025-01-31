import 'package:every_home_flutter/helper/utils/general_imports.dart';
import 'package:flutter/material.dart';

enum NetworkStatus { online, offline }

enum ThemeList { systemDefault, light, dark }

class Constant {
  //Add your admin panel url here with postfix slash eg. https://www.admin.panel/
  // TODO ADMIN PANEL URL HERE
  static String hostUrl = "";

  static String baseUrl = "";

  static String packageName = "com.tltechnologies.everyhome";

  // TODO IOS APP URL HERE
  static String appStoreUrl = "";

  // TODO ANDROID APP URL HERE
  static String playStoreUrl = "";

  static int minimumRequiredMobileNumberLength = 7;

  static String notificationChannel = "Basic notifications";

  //authenticationScreen with phone constants
  static int messageDisplayDuration = 3500; // resend otp timer

  static int defaultImagesLoadLimitAtOnce = 50;

  static int discountCouponDialogVisibilityTimeInMilliseconds = 3000;

  static SharedPreferences? prefs;

  // TODO LOGIN SCREEN INITIAL SELECTED COUNTRY HERE
  // initial country code, change as per your requirement
  static String initialCountryCode = "IN";

  // Theme list, This system default names please do not change at all
  static List<String> themeList = ["System default", "Light", "Dark"];

  static GlobalKey<NavigatorState> navigatorKay = GlobalKey<NavigatorState>();

  //google api keys
  static String googleApiKey = "";

  static BorderRadius borderRadius2 = BorderRadius.circular(2);
  static BorderRadius borderRadius5 = BorderRadius.circular(5);
  static BorderRadius borderRadius7 = BorderRadius.circular(7);
  static BorderRadius borderRadius10 = BorderRadius.circular(10);
  static BorderRadius borderRadius13 = BorderRadius.circular(13);

  static List<String> searchedItemsHistoryList = [];

  static String authTypePhoneLogin = "0";
  static String firebaseAuthentication = "0";

  static late SessionManager session;

  static Map cityAddressMap = {};

  // App Settings
  static List<int> favorits = [];
  static String currency = "";
  static String referEarnBonus = "";
  static String maximumReferEarnAmount = "";
  static String minimumWithdrawalAmount = "";
  static String userWalletRefillLimit = "";
  static String isReferEarnOn = "";
  static String referEarnMethod = "";
  static String privacyPolicy = "";
  static String termsConditions = "";
  static String aboutUs = "";
  static String contactUs = "";
  static String returnAndExchangesPolicy = "";
  static String cancellationPolicy = "";
  static String shippingPolicy = "";
  static String currencyCode = "";
  static String decimalPoints = "0";

  static String appMaintenanceMode = "";
  static String appMaintenanceModeRemark = "";

  static String currentRequiredAppVersion = "";
  static String requiredForceUpdate = "";
  static String isVersionSystemOn = "";

  static String currentRequiredIosAppVersion = "";
  static String requiredIosForceUpdate = "";
  static String isIosVersionSystemOn = "";

  static String getAssetsPath(int folder, String filename) {
    //0-image,1-svg,2-language,3-animation

    String path = "";
    switch (folder) {
      case 0:
        path = "assets/images/$filename";
        break;
      case 1:
        path = "assets/svg/$filename.svg";
        break;
      case 2:
        path = "assets/language/$filename.json";
        break;
      case 3:
        path = "assets/animation/$filename.json";
        break;
      case 4:
        path = "assets/$filename.json";
    }

    return path;
  }

  //Default padding and margin variables

  static double size2 = 2.00;
  static double size3 = 3.00;
  static double size5 = 5.00;
  static double size7 = 7.00;
  static double size8 = 8.00;
  static double size10 = 10.00;
  static double size12 = 12.00;
  static double size14 = 14.00;
  static double size15 = 15.00;
  static double size18 = 18.00;
  static double size20 = 20.00;
  static double size25 = 20.00;
  static double size30 = 30.00;
  static double size35 = 35.00;
  static double size40 = 40.00;
  static double size50 = 50.00;
  static double size60 = 60.00;
  static double size65 = 65.00;
  static double size70 = 70.00;
  static double size75 = 75.00;
  static double size80 = 80.00;

  static Future<String> getGetMethodUrlWithParams(
      String mainUrl, Map params) async {
    if (params.isNotEmpty) {
      mainUrl = "$mainUrl?";
      for (int i = 0; i < params.length; i++) {
        mainUrl =
            "$mainUrl${i == 0 ? "" : "&"}${params.keys.toList()[i]}=${params.values.toList()[i]}";
      }
    }

    return mainUrl;
  }

  static String apiGeoCode =
      "https://maps.googleapis.com/maps/api/geocode/json?key=$googleApiKey&latlng=";

  static String noInternetConnection = "no_internet_connection";
  static String somethingWentWrong = "something_went_wrong";
}
