import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:every_home_flutter/helper/utils/general_imports.dart';

enum MessageType { success, error, warning }

Map<MessageType, Color> messageColors = {
  MessageType.success: Colors.green,
  MessageType.error: Colors.red,
  MessageType.warning: Colors.orange
};

Map<MessageType, Widget> messageIcon = {
  MessageType.success: defaultImg(image: "ic_done", iconColor: Colors.green),
  MessageType.error: defaultImg(image: "ic_error", iconColor: Colors.red),
  MessageType.warning:
      defaultImg(image: "ic_warning", iconColor: Colors.orange),
};

Future<bool> checkInternetConnection() async {
  bool check = false;

  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult[0] == ConnectivityResult.mobile ||
      connectivityResult[0] == ConnectivityResult.wifi ||
      connectivityResult[0] == ConnectivityResult.ethernet) {
    check = true;
  }
  return check;
}

showMessage(
  BuildContext context,
  String msg,
  MessageType type,
) async {
  FocusScope.of(context).unfocus(); // Unfocused any focused text field
  SystemChannels.textInput.invokeMethod('TextInput.hide'); // Close the keyboard

  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        left: 5,
        right: 5,
        bottom: 15,
        child: MessageContainer(
          context: context,
          text: msg,
          type: type,
        ),
      );
    },
  );
  overlayState.insert(overlayEntry);
  await Future.delayed(
    Duration(
      milliseconds: Constant.messageDisplayDuration,
    ),
  );

  overlayEntry.remove();
}

String setFirstLetterUppercase(String value) {
  if (value.isNotEmpty) value = value.replaceAll("_", ' ');
  return value.toTitleCase();
}

Future sendApiRequest(
    {required String apiName,
    required Map<String, dynamic> params,
    required bool isPost,
    required BuildContext context,
    bool? isRequestedForInvoice}) async {
  try {
    String token = Constant.session.getData(SessionManager.keyToken);

    Map<String, String> headersData = {
      "accept": "application/json",
    };

    if (token.trim().isNotEmpty) {
      headersData["Authorization"] = "Bearer $token";
    }

    headersData["x-access-key"] = "903361";

    String mainUrl =
        apiName.contains("http") ? apiName : "${Constant.baseUrl}$apiName";

    http.Response response;
    if (isPost) {
      response = await http.post(Uri.parse(mainUrl),
          body: params.isNotEmpty ? params : null, headers: headersData);
    } else {
      mainUrl = await Constant.getGetMethodUrlWithParams(
          apiName.contains("http") ? apiName : "${Constant.baseUrl}$apiName",
          params);

      response = await http.get(Uri.parse(mainUrl), headers: headersData);
    }

    if (kDebugMode) {
      debugPrint("API IS ${"$mainUrl,{$params}, ${response.body}"}");
    }

    if (response.statusCode == 200) {
      if (response.body == "null") {
        return null;
      }

      return isRequestedForInvoice == true ? response.bodyBytes : response.body;
    } else {
      if (kDebugMode) {
        print(
            "ERROR IS ${"$mainUrl,{$params},Status Code - ${response.statusCode}, ${response.body}"}");
        showMessage(
          context,
          "$mainUrl,{$params},Status Code - ${response.statusCode}",
          MessageType.warning,
        );
      }
      return null;
    }
  } on SocketException {
    throw Constant.noInternetConnection;
  } catch (c) {
    if (kDebugMode) {
      showMessage(
        context,
        c.toString(),
        MessageType.warning,
      );
    }
    throw Constant.somethingWentWrong;
  }
}

Future sendApiMultiPartRequest(
    {required String apiName,
    required Map<String, String> params,
    required List<String> fileParamsNames,
    required List<String> fileParamsFilesPath,
    required BuildContext context}) async {
  try {
    Map<String, String> headersData = {};

    String token = Constant.session.getData(SessionManager.keyToken);

    String mainUrl =
        apiName.contains("http") ? apiName : "${Constant.baseUrl}$apiName";

    headersData["Authorization"] = "Bearer $token";
    headersData["x-access-key"] = "903361";
    var request = http.MultipartRequest('POST', Uri.parse(mainUrl));

    request.fields.addAll(params);

    if (fileParamsNames.isNotEmpty) {
      for (int i = 0; i <= (fileParamsNames.length - 1); i++) {
        request.files.add(await http.MultipartFile.fromPath(
            fileParamsNames[i].toString(), fileParamsFilesPath[i].toString()));
      }
    }
    request.headers.addAll(headersData);

    http.StreamedResponse response = await request.send();

    var data = await response.stream.bytesToString();
    return data;
  } on SocketException {
    throw Constant.noInternetConnection;
  } catch (c) {
    if (kDebugMode) {
      showMessage(
        context,
        c.toString(),
        MessageType.warning,
      );
    }
    throw Constant.somethingWentWrong;
  }
}

String? validateEmail(String value) {
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.trim().isEmpty || !regex.hasMatch(value)) {
    return "";
  } else {
    return null;
  }
}

emptyValidation(String val) {
  if (val.trim().isEmpty) {
    return "";
  }
  return null;
}

amountValidation(String val) {
  if (val.trim().isEmpty) {
    return "";
  } else if (val.trim().isNotEmpty) {
    return (val.toDouble > 0 == true) ? null : "";
  } else {
    return null;
  }
}

optionalValidation(String val) {
  return null;
}

phoneValidation(String value) {
  String pattern = r'[0-9]';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty ||
      !regExp.hasMatch(value) ||
      value.length >= 16 ||
      value.length < Constant.minimumRequiredMobileNumberLength) {
    return "";
  }
  return null;
}

optionalPhoneValidation(String value) {
  if (value.isEmpty) {
    {
      return null;
    }
  } else {
    String pattern = r'[0-9]';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty ||
        !regExp.hasMatch(value) ||
        value.length > 15 ||
        value.length < Constant.minimumRequiredMobileNumberLength) {
      return "";
    }
    return null;
  }
}

getUserLocation() async {
  LocationPermission permission;

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openLocationSettings();

    getUserLocation();
  } else if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      await Geolocator.openLocationSettings();
      getUserLocation();
    } else {
      getUserLocation();
    }
  }
}

Future<GeoAddress?> displayPrediction(
    Prediction? p, BuildContext context) async {
  if (p != null) {
    GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: Constant.googleApiKey);

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    String zipcode = "";
    GeoAddress address = GeoAddress();

    address.placeId = p.placeId;

    for (AddressComponent component in detail.result.addressComponents) {
      if (component.types.contains('locality')) {
        address.city = component.longName;
      }
      if (component.types.contains('administrative_area_level_2')) {
        address.district = component.longName;
      }
      if (component.types.contains('administrative_area_level_1')) {
        address.state = component.longName;
      }
      if (component.types.contains('country')) {
        address.country = component.longName;
      }
      if (component.types.contains('postal_code')) {
        zipcode = component.longName;
      }
    }

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

//if zipcode not found
    if (zipcode.trim().isEmpty) {
      zipcode = await getZipCode(lat, lng, context);
    }
//
    address.address = detail.result.formattedAddress;
    address.lattitud = lat.toString();
    address.longitude = lng.toString();
    address.zipcode = zipcode;
    return address;
  }
  return null;
}

getZipCode(double lat, double lng, BuildContext context) async {
  String zipcode = "";
  var result = await sendApiRequest(
      apiName: "${Constant.apiGeoCode}$lat,$lng",
      params: {},
      isPost: false,
      context: context);
  if (result != null) {
    var getData = json.decode(result);
    if (getData != null) {
      Map data = getData['results'][0];
      List addressInfo = data['address_components'];
      for (var info in addressInfo) {
        List type = info['types'];
        if (type.contains('postal_code')) {
          zipcode = info['long_name'];
          break;
        }
      }
    }
  }
  return zipcode;
}

Future<Map<String, dynamic>> getCityNameAndAddress(
    LatLng currentLocation, BuildContext context) async {
  try {
    Map<String, dynamic> response = json.decode(await sendApiRequest(
        apiName:
            "${Constant.apiGeoCode}${currentLocation.latitude},${currentLocation.longitude}",
        params: {},
        isPost: false,
        context: context));
    final possibleLocations = response['results'] as List;
    Map location = {};
    String cityName = '';
    String stateName = '';
    String pinCode = '';
    String countryName = '';
    String landmark = '';
    String area = '';

    if (possibleLocations.isNotEmpty) {
      for (var locationFullDetails in possibleLocations) {
        Map latLng = Map.from(locationFullDetails['geometry']['location']);
        double lat = double.parse(latLng['lat'].toString());
        double lng = double.parse(latLng['lng'].toString());
        if (lat == currentLocation.latitude &&
            lng == currentLocation.longitude) {
          location = Map.from(locationFullDetails);
          break;
        }
      }
//If we could not find location with given lat and lng
      if (location.isNotEmpty) {
        final addressComponents = location['address_components'] as List;
        if (addressComponents.isNotEmpty) {
          for (var component in addressComponents) {
            if ((component['types'] as List).contains('locality') &&
                cityName.isEmpty) {
              cityName = component['long_name'].toString();
            }
            if ((component['types'] as List)
                    .contains('administrative_area_level_1') &&
                stateName.isEmpty) {
              stateName = component['long_name'].toString();
            }
            if ((component['types'] as List).contains('country') &&
                countryName.isEmpty) {
              countryName = component['long_name'].toString();
            }
            if ((component['types'] as List).contains('postal_code') &&
                pinCode.isEmpty) {
              pinCode = component['long_name'].toString();
            }
            if ((component['types'] as List).contains('sublocality') &&
                landmark.isEmpty) {
              landmark = component['long_name'].toString();
            }
            if ((component['types'] as List).contains('route') &&
                area.isEmpty) {
              area = component['long_name'].toString();
            }
          }
        }
      } else {
        location = Map.from(possibleLocations.first);
        final addressComponents = location['address_components'] as List;
        if (addressComponents.isNotEmpty) {
          for (var component in addressComponents) {
            if ((component['types'] as List).contains('locality') &&
                cityName.isEmpty) {
              cityName = component['long_name'].toString();
            }
            if ((component['types'] as List)
                    .contains('administrative_area_level_1') &&
                stateName.isEmpty) {
              stateName = component['long_name'].toString();
            }
            if ((component['types'] as List).contains('country') &&
                countryName.isEmpty) {
              countryName = component['long_name'].toString();
            }
            if ((component['types'] as List).contains('postal_code') &&
                pinCode.isEmpty) {
              pinCode = component['long_name'].toString();
            }
            if ((component['types'] as List).contains('sublocality') &&
                landmark.isEmpty) {
              landmark = component['long_name'].toString();
            }
            if ((component['types'] as List).contains('route') &&
                area.isEmpty) {
              area = component['long_name'].toString();
            }
          }
        }
      }

      return {
        'address': possibleLocations.first['formatted_address'],
        'city': cityName,
        'state': stateName,
        'pin_code': pinCode,
        'country': countryName,
        'area': area,
        'landmark': landmark,
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,
      };
    }
    return {};
  } catch (e) {
    showMessage(
      context,
      e.toString(),
      MessageType.warning,
    );
    return {};
  }
}

Future<PermissionStatus> hasStoragePermissionGiven() async {
  try {
    if (Platform.isIOS) {
      bool permissionGiven = await Permission.storage.isGranted;
      if (!permissionGiven) {
        permissionGiven = (await Permission.storage.request()).isGranted;
        return Permission.storage.status;
      }
      return Permission.storage.status;
    }

    //if it is for android
    final deviceInfoPlugin = DeviceInfoPlugin();
    final androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    if (androidDeviceInfo.version.sdkInt < 33) {
      bool permissionGiven = await Permission.storage.isGranted;
      if (!permissionGiven) {
        permissionGiven = (await Permission.storage.request()).isGranted;
        return Permission.storage.status;
      }
      return Permission.storage.status;
    } else {
      bool permissionGiven = await Permission.photos.isGranted;
      if (!permissionGiven) {
        permissionGiven = (await Permission.photos.request()).isGranted;
        return Permission.storage.status;
      }
      return Permission.storage.status;
    }
  } catch (e) {
    return Permission.storage.status;
  }
}

Future<dynamic> hasCameraPermissionGiven(BuildContext context) async {
  try {
    bool permissionGiven = await Permission.camera.isGranted;
    if (!permissionGiven) {
      permissionGiven = (await Permission.camera.request()).isGranted;
      return Permission.camera.status;
    }
    return Permission.camera.status;
  } catch (e) {
    showMessage(context, e.toString(), MessageType.error);
    return false;
  }
}

Future<dynamic> hasLocationPermissionGiven() async {
  try {
    bool permissionGiven = await Permission.location.isGranted;
    if (!permissionGiven) {
      permissionGiven = (await Permission.location.request()).isGranted;
      return Permission.location.status;
    }
    return Permission.location.status;
  } catch (e) {
    return false;
  }
}

String getTranslatedValue(BuildContext context, String jsonKey) {
  return jsonKey;
}

int getColorFromHex(
    String darkHexColor, String lightHexColor, BuildContext context) {
  darkHexColor = darkHexColor.toUpperCase().replaceAll("#", "");
  if (darkHexColor.length == 6) {
    darkHexColor = "FF$darkHexColor";
  }
  lightHexColor = lightHexColor.toUpperCase().replaceAll("#", "");
  if (lightHexColor.length == 6) {
    lightHexColor = "FF$lightHexColor";
  }

  return int.parse(
      Constant.session.getBoolData(SessionManager.isDarkTheme)
          ? darkHexColor
          : lightHexColor,
      radix: 16);
}

double calculateDiscountPercentage(
    {required double discount, required double originalPrice}) {
  return ((originalPrice - discount / originalPrice) * 100).toPrecision(2);
}

///Social Media Authentication Starts Here

//signIn using google account
// Future signInWithGoogle(
//     {required BuildContext context,
//     required FirebaseAuth firebaseAuth,
//     required GoogleSignIn googleSignIn}) async {
//   final googleUser = await googleSignIn.signIn();
//   if (googleUser == null) {
//     throw getTranslatedValue(context, "something_went_wrong");
//   }
//   final googleAuth = await googleUser.authentication;

//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   return firebaseAuth.signInWithCredential(credential);
// }

// Future signInWithApple(
//     {required BuildContext context,
//     required FirebaseAuth firebaseAuth,
//     required GoogleSignIn googleSignIn}) async {
//   try {
//     final credential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//     );

//     final oAuthCredential = OAuthProvider('apple.com').credential(
//       idToken: credential.identityToken,
//       accessToken: credential.authorizationCode,
//     );
//     final userCredential =
//         await firebaseAuth.signInWithCredential(oAuthCredential);

//     if (userCredential.additionalUserInfo!.isNewUser ||
//         userCredential.user!.displayName == null) {
//       final user = userCredential.user!;
//       final givenName = credential.givenName ?? '';
//       final familyName = credential.familyName ?? '';

//       await user.updateDisplayName('$givenName $familyName');
//       await user.reload();
//     }

//     return userCredential;
//   } catch (error) {
//     throw error.toString();
//   }
// }

// Future<void> signOut(
//     {required AuthProviders authProvider,
//     required FirebaseAuth firebaseAuth,
//     required GoogleSignIn googleSignIn}) async {
//   await firebaseAuth.signOut();
//   if (authProvider == AuthProviders.google) {
//     await googleSignIn.signOut();
//   }
// }

///Social Media Authentication Ends Here

///EXTENSIONS STARTS FROM HERE

extension CurrencyConverter on String {
  String get currency => NumberFormat.currency(
          locale: Platform.localeName,
          symbol: Constant.currency,
          decimalDigits: int.parse(Constant.decimalPoints.toString()),
          name: Constant.currencyCode)
      .format(toDouble);

  double get toDouble =>
      double.tryParse(double.tryParse(this)?.toStringAsFixed(2) ?? "0.00") ??
      0.0;

  int get toInt => int.tryParse(this) ?? 0;
}

extension StringToDateTimeFormatting on String {
  DateTime toDate({String format = 'd MMM y, hh:mm a'}) {
    try {
      return DateTime.parse(this).toLocal();
    } catch (e) {
      print('Error parsing date: $e');
      return DateTime.now();
    }
  }

  String formatDate(
      {String inputFormat = 'yyyy-MM-dd',
      String outputFormat = 'd MMM y, hh:mm a'}) {
    try {
      DateTime dateTime = toDate(format: inputFormat);
      return DateFormat(outputFormat).format(dateTime);
    } catch (e) {
      print('Error formatting date: $e');
      return this; // Return the original string if there's an error
    }
  }

  String formatEstimateDate(
      {String inputFormat = 'yyyy-MM-dd', String outputFormat = 'd MMM y'}) {
    try {
      DateTime dateTime = toDate(format: inputFormat);
      return DateFormat(outputFormat).format(dateTime);
    } catch (e) {
      print('Error formatting date: $e');
      return this; // Return the original string if there's an error
    }
  }
}

extension Precision on double {
  double toPrecision(int fractionDigits) {
    num mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension ContextExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;
}

///EXTENSIONS ENDS HERE
