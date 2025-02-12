import 'package:every_home_flutter/helper/utils/general_imports.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: defaultImg(image: 'welcome_screen.png', height: 0.4.sh),
            ),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorsRes.mainTextColorDark
                          : ColorsRes.mainTextColorLight,
                    ),
                  ),
                  Text(
                    'Professional Services\n Product Details a Click Away',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ColorsRes.subTitleTextColorDark
                          : ColorsRes.subTitleTextColorLight,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50.h,
              left: 50.w,
              right: 50.w,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/onboarding');
                },
                child: const Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
