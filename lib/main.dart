import 'package:every_home_flutter/helper/utils/general_imports.dart';
import 'package:get/get.dart';

late final SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  Get.put(SessionManager(prefs: prefs));

  Constant.session = Get.find<SessionManager>();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: const MyApp(),
  ));

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    Constant.session.handleSystemThemeChange();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, _) {
        return Obx(() {
          final themeMode = Constant.session.getCurrentThemeNo();
          print('Theme Mode: $themeMode');

          return GetMaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Every Home',
            theme: ColorsRes.lightTheme,
            darkTheme: ColorsRes.darkTheme,
            themeMode: switch (Constant.session.getCurrentThemeNo()) {
              1 => ThemeMode.system,
              2 => ThemeMode.light,
              3 => ThemeMode.dark,
              _ => ThemeMode.system,
            },
            home: const ScreenSplash(),
          );
        });
      },
    );
  }
}
