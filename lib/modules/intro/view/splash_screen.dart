import 'package:every_home_flutter/helper/utils/general_imports.dart';
import 'package:every_home_flutter/modules/intro/view/welcome_screen.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const WelcomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const IconButton(onPressed: null, icon: Icon(null)),
              defaultImg(image: "logo_light", height: 220.h),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  Text(
                    'from'.tr(),
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorsRes.subTitleTextColorDark
                          : ColorsRes.subTitleTextColorLight,
                    ),
                  ),
                  Text(
                    'company_name'.tr(),
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorsRes.mainTextColorDark
                          : ColorsRes.mainTextColorLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
