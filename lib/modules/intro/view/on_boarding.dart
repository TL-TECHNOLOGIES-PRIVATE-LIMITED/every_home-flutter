import 'package:every_home_flutter/helper/utils/general_imports.dart';
import 'package:every_home_flutter/modules/intro/model/on_boarding_model.dart';
import 'package:get/get.dart' hide Trans;

class ScreenOnBoarding extends StatefulWidget {
  const ScreenOnBoarding({super.key});

  @override
  State<ScreenOnBoarding> createState() => _ScreenOnBoardingState();
}

class _ScreenOnBoardingState extends State<ScreenOnBoarding> {
  RxInt currentIndex = 0.obs;
  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      title: "on_boarding_title_1".tr(),
      description: "on_boarding_description_1".tr(),
      image: "enabler.png",
    ),
    OnBoardingModel(
      title: "on_boarding_title_2".tr(),
      description: "on_boarding_description_2".tr(),
      image: "enabler.png",
    ),
    OnBoardingModel(
      title: "on_boarding_title_3".tr(),
      description: "on_boarding_description_3".tr(),
      image: "enabler.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Obx(() {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  defaultImg(
                      image: onBoardingList[currentIndex.value].image,
                      height: 250.h),
                  Text(onBoardingList[currentIndex.value].title),
                  Text(onBoardingList[currentIndex.value].description),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentIndex.value != 0
                          ? IconButton(
                              onPressed: () {
                                if (currentIndex.value > 0) {
                                  currentIndex.value--;
                                }
                              },
                              icon: const Icon(Icons.arrow_back_ios),
                            )
                          : const SizedBox(),
                      IconButton(
                        onPressed: () {
                          if (currentIndex.value < onBoardingList.length - 1 &&
                              currentIndex.value != 2) {
                            currentIndex.value++;
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const ScreenSplash()));
                          }
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
