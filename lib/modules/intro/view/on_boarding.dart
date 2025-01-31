import 'package:every_home_flutter/helper/utils/general_imports.dart';
import 'package:get/get.dart';

class ScreenOnBoarding extends StatefulWidget {
  const ScreenOnBoarding({super.key});

  @override
  State<ScreenOnBoarding> createState() => _ScreenOnBoardingState();
}

class _ScreenOnBoardingState extends State<ScreenOnBoarding> {
  @override
  Widget build(BuildContext context) {
    final sessionManager = Get.find<SessionManager>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => RadioListTile<int>(
                  fillColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context).brightness == Brightness.dark
                          ? ColorsRes.appColorDark
                          : ColorsRes.appColor; // Active color
                    }
                    return Theme.of(context).brightness == Brightness.dark
                        ? ColorsRes.subTitleTextColorDark
                        : ColorsRes.subTitleTextColorLight; // Inactive color
                  }),
                  activeColor: ColorsRes.appColor,
                  title: Text(
                    'System Theme',
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorsRes.mainTextColorDark
                            : ColorsRes.mainTextColorLight),
                  ),
                  value: 1,
                  groupValue:
                      sessionManager.getCurrentThemeNo(), // Observe changes
                  onChanged: (value) {
                    sessionManager.toggleTheme(value!);
                  },
                )),
            Obx(() => RadioListTile<int>(
                  fillColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context).brightness == Brightness.dark
                          ? ColorsRes.appColorDark
                          : ColorsRes.appColor; // Active color
                    }
                    return Theme.of(context).brightness == Brightness.dark
                        ? ColorsRes.subTitleTextColorDark
                        : ColorsRes.subTitleTextColorLight; // Inactive color
                  }),
                  activeColor: ColorsRes.appColor,
                  title: Text(
                    'Light Theme',
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorsRes.mainTextColorDark
                            : ColorsRes.mainTextColorLight),
                  ),
                  value: 2,
                  groupValue:
                      sessionManager.getCurrentThemeNo(), // Observe changes
                  onChanged: (value) {
                    sessionManager.toggleTheme(value!);
                  },
                )),
            Obx(() => RadioListTile<int>(
                  fillColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context).brightness == Brightness.dark
                          ? ColorsRes.appColorDark
                          : ColorsRes.appColor; // Active color
                    }
                    return Theme.of(context).brightness == Brightness.dark
                        ? ColorsRes.subTitleTextColorDark
                        : ColorsRes.subTitleTextColorLight; // Inactive color
                  }),

                  title: Text(
                    'Dark Theme',
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorsRes.mainTextColorDark
                            : ColorsRes.mainTextColorLight),
                  ),
                  value: 3,
                  groupValue:
                      sessionManager.getCurrentThemeNo(), // Observe changes
                  onChanged: (value) {
                    sessionManager.toggleTheme(value!);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
