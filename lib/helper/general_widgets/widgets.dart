import 'package:every_home_flutter/helper/utils/general_imports.dart';
import 'package:flutter/material.dart';

getDarkLightIcon({
  double? height,
  double? width,
  required String image,
  Color? iconColor,
  BoxFit? boxFit,
  EdgeInsetsDirectional? padding,
  bool? isActive,
}) {
  String dark =
      (Constant.session.getBoolData(SessionManager.isDarkTheme)) == true
          ? "_dark"
          : "";
  String active = (isActive ??= false) == true ? "_active" : "";

  return defaultImg(
      height: height,
      width: width,
      image: "$image$active${dark}_icon",
      iconColor: iconColor,
      boxFit: boxFit,
      padding: padding);
}

List getHomeBottomNavigationBarIcons({required bool isActive}) {
  return [
    getDarkLightIcon(
        image: "home",
        isActive: isActive,
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0)),
    getDarkLightIcon(
        image: "category",
        isActive: isActive,
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0)),
    getDarkLightIcon(
        image: "wishlist",
        isActive: isActive,
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0)),
    getDarkLightIcon(
        image: "profile",
        isActive: isActive,
        padding: EdgeInsetsDirectional.zero),
  ];
}

// Widget setNetworkImg({
//   double? height,
//   double? width,
//   String image = "placeholder.png",
//   Color? iconColor,
//   BoxFit? boxFit,
//   BorderRadius? borderRadius,
// }) {
//   if (image.trim().isNotEmpty && !image.contains("http")) {
//     image = "${Constant.hostUrl}storage/$image";
//   }

//   return image.trim().isEmpty
//       ? defaultImg(
//           image: "placeholder.png",
//           height: height,
//           width: width,
//           boxFit: boxFit,
//         )
//       : Container(
//           height: height,
//           width: width,
//           decoration: BoxDecoration(
//             borderRadius: borderRadius,
//             image: DecorationImage(
//               image: CachedNetworkImageProvider(image),
//               fit: boxFit,
//             ),
//           ),
//           child: CachedNetworkImage(
//             imageUrl: image,
//             height: height,
//             width: width,
//             fit: boxFit,
//             placeholder: (context, url) => defaultImg(
//               image: "placeholder.png",
//               boxFit: boxFit,
//             ),
//           ),
//         );
// }

Widget defaultImg({
  double? height,
  double? width,
  required String image,
  Color? iconColor,
  BoxFit? boxFit,
  EdgeInsetsDirectional? padding,
  bool? requiredRTL = true,
}) {
  return Padding(
    padding: padding ?? const EdgeInsets.all(0),
    child: (image.contains("png") ||
            image.contains("jpeg") ||
            image.contains("jpg"))
        ? Image.asset(Constant.getAssetsPath(0, image))
        : SvgPicture.asset(
            Constant.getAssetsPath(1, image),
            width: width,
            height: height,
            colorFilter: iconColor != null
                ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                : null,
            fit: boxFit ?? BoxFit.contain,
            matchTextDirection: requiredRTL ?? true,
          ),
  );
}

Widget getSizedBox({double? height, double? width, Widget? child}) {
  return SizedBox(
    height: height ?? 0,
    width: width ?? 0,
    child: child,
  );
}

Widget getDivider(
    {Color? color,
    double? endIndent,
    double? height,
    double? indent,
    double? thickness}) {
  return Divider(
    color: color ?? ColorsRes.subTitleMainTextColor,
    endIndent: endIndent ?? 0,
    indent: indent ?? 0,
    height: height,
    thickness: thickness,
  );
}

getLoadingIndicator() {
  return CircularProgressIndicator(
    backgroundColor: Colors.transparent,
    color: ColorsRes.appColor,
    strokeWidth: 2,
  );
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class CustomShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;

  const CustomShimmer(
      {super.key, this.height, this.width, this.borderRadius, this.margin});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: ColorsRes.shimmerBaseColor,
      highlightColor: ColorsRes.shimmerHighlightColor,
      child: Container(
        width: width,
        margin: margin ?? EdgeInsets.zero,
        height: height ?? 10,
        decoration: BoxDecoration(
            color: ColorsRes.shimmerContentColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 10)),
      ),
    );
  }
}

// CategorySimmer
Widget getCategoryShimmer(
    {required BuildContext context, int? count, EdgeInsets? padding}) {
  return GridView.builder(
    itemCount: count,
    padding: padding ??
        EdgeInsets.symmetric(
            horizontal: Constant.size10, vertical: Constant.size10),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return CustomShimmer(
        width: context.width,
        height: context.height,
        borderRadius: 8,
      );
    },
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10),
  );
}

// CategorySimmer
Widget getRatingPhotosShimmer(
    {required BuildContext context, int? count, EdgeInsets? padding}) {
  return GridView.builder(
    itemCount: count,
    padding: padding ??
        EdgeInsets.symmetric(
            horizontal: Constant.size10, vertical: Constant.size10),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return CustomShimmer(
        width: context.width,
        height: context.height,
        borderRadius: 8,
      );
    },
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10),
  );
}

AppBar getAppBar(
    {required BuildContext context,
    bool? centerTitle,
    required Widget title,
    List<Widget>? actions,
    Color? backgroundColor,
    bool? showBackButton,
    GestureTapCallback? onTap}) {
  return AppBar(
    leading: showBackButton ?? true
        ? GestureDetector(
            onTap: onTap ??
                () {
                  Navigator.pop(context);
                },
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: defaultImg(
                    boxFit: BoxFit.contain,
                    image: "ic_arrow_back",
                    iconColor: ColorsRes.mainTextColor,
                  ),
                ),
              ),
            ),
          )
        : null,
    automaticallyImplyLeading: true,
    elevation: 0,
    titleSpacing: 0,
    title: Row(
      children: [
        if (showBackButton == false || !Navigator.of(context).canPop())
          getSizedBox(
            width: 10,
          ),
        Expanded(child: title),
      ],
    ),
    centerTitle: centerTitle ?? false,
    surfaceTintColor: Colors.transparent,
    backgroundColor: backgroundColor ?? Theme.of(context).cardColor,
    actions: actions ?? [],
  );
}

class ScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }
}

Widget getProductListShimmer(
    {required BuildContext context, required bool isGrid}) {
  return isGrid
      ? GridView.builder(
          itemCount: 6,
          padding: EdgeInsets.symmetric(
              horizontal: Constant.size10, vertical: Constant.size10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return const CustomShimmer(
              width: double.maxFinite,
              height: double.maxFinite,
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
        )
      : Column(
          children: List.generate(20, (index) {
            return const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
              child: CustomShimmer(
                width: double.maxFinite,
                height: 125,
              ),
            );
          }),
        );
}

Widget getProductItemShimmer(
    {required BuildContext context, required bool isGrid}) {
  return isGrid
      ? GridView.builder(
          itemCount: 2,
          padding: EdgeInsets.symmetric(
              horizontal: Constant.size10, vertical: Constant.size10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return const CustomShimmer(
              width: double.maxFinite,
              height: double.maxFinite,
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
        )
      : const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
          child: CustomShimmer(
            width: double.maxFinite,
            height: 125,
          ),
        );
}

Widget setRefreshIndicator(
    {required RefreshCallback refreshCallback, required Widget child}) {
  return RefreshIndicator(
    onRefresh: refreshCallback,
    backgroundColor: Colors.transparent,
    color: ColorsRes.appColor,
    triggerMode: RefreshIndicatorTriggerMode.anywhere,
    child: child,
  );
}

// Widget setCartCounter({required BuildContext context, String? from}) {
//   return GestureDetector(
//     onTap: () {
//       if (from == null) {
//         Navigator.pushNamed(context, cartScreen);
//       } else {
//         Navigator.pop(context);
//       }
//     },
//     child: Container(
//       margin: const EdgeInsets.all(10),
//       child: Stack(
//         children: [
//           defaultImg(
//               height: 24,
//               width: 24,
//               iconColor: ColorsRes.appColor,
//               image: "cart_icon"),
//           Consumer<CartListProvider>(
//             builder: (context, cartListProvider, child) {
//               return context.read<CartListProvider>().cartList.length > 0
//                   ? PositionedDirectional(
//                       end: 0,
//                       top: 0,
//                       child: SizedBox(
//                         height: 12,
//                         width: 12,
//                         child: CircleAvatar(
//                           radius: 50,
//                           backgroundColor: ColorsRes.appColor,
//                           child: CustomTextLabel(
//                             text: context
//                                 .read<CartListProvider>()
//                                 .cartList
//                                 .length
//                                 .toString(),
//                             softWrap: true,
//                             style: TextStyle(
//                               color: ColorsRes.mainIconColor,
//                               fontSize: 10,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   : const SizedBox.shrink();
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget setNotificationIcon({required BuildContext context}) {
//   return IconButton(
//     onPressed: () {
//       Navigator.pushNamed(context, notificationListScreen);
//     },
//     icon: defaultImg(
//       image: "notification_icon",
//       iconColor: ColorsRes.appColor,
//     ),
//   );
// }

// Widget getOverallRatingSummary(
//     {required BuildContext context,
//     required ProductRatingData productRatingData,
//     required String totalRatings}) {
//   return Row(
//     children: [
//       Column(
//         children: [
//           CircleAvatar(
//             backgroundColor: ColorsRes.appColor,
//             maxRadius: 45,
//             minRadius: 20,
//             child: CustomTextLabel(
//               text: "${productRatingData.averageRating.toString().toDouble}",
//               style: TextStyle(
//                 color: ColorsRes.appColorWhite,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 35,
//               ),
//             ),
//           ),
//           getSizedBox(height: 10),
//           CustomTextLabel(
//             text:
//                 "${getTranslatedValue(context, "rating")}\n${totalRatings.toString().toInt}",
//             style: TextStyle(
//               color: ColorsRes.subTitleMainTextColor,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//       Container(
//         margin: const EdgeInsetsDirectional.only(start: 20, end: 20),
//         color: ColorsRes.subTitleMainTextColor,
//         height: 165,
//         width: 0.7,
//       ),
//       Expanded(
//         child: Column(
//           children: [
//             PercentageWiseRatingBar(
//               context: context,
//               index: 4,
//               totalRatings: productRatingData.fiveStarRating.toString().toInt,
//               ratingPercentage: calculatePercentage(
//                 totalRatings: totalRatings.toString().toInt,
//                 starsWiseRatings:
//                     productRatingData.fiveStarRating.toString().toInt,
//               ),
//             ),
//             PercentageWiseRatingBar(
//               context: context,
//               index: 3,
//               totalRatings: productRatingData.fourStarRating.toString().toInt,
//               ratingPercentage: calculatePercentage(
//                 totalRatings: totalRatings.toString().toInt,
//                 starsWiseRatings:
//                     productRatingData.fourStarRating.toString().toInt,
//               ),
//             ),
//             PercentageWiseRatingBar(
//               context: context,
//               index: 2,
//               totalRatings: productRatingData.threeStarRating.toString().toInt,
//               ratingPercentage: calculatePercentage(
//                 totalRatings: totalRatings.toString().toInt,
//                 starsWiseRatings:
//                     productRatingData.threeStarRating.toString().toInt,
//               ),
//             ),
//             PercentageWiseRatingBar(
//               context: context,
//               index: 1,
//               totalRatings: productRatingData.twoStarRating.toString().toInt,
//               ratingPercentage: calculatePercentage(
//                 totalRatings: totalRatings.toString().toInt,
//                 starsWiseRatings:
//                     productRatingData.twoStarRating.toString().toInt,
//               ),
//             ),
//             PercentageWiseRatingBar(
//               context: context,
//               index: 0,
//               totalRatings: productRatingData.oneStarRating.toString().toInt,
//               ratingPercentage: calculatePercentage(
//                 totalRatings: totalRatings.toString().toInt,
//                 starsWiseRatings:
//                     productRatingData.oneStarRating.toString().toInt,
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }

Widget PercentageWiseRatingBar({
  required double ratingPercentage,
  required int totalRatings,
  required int index,
  required BuildContext context,
}) {
  return Column(
    children: [
      Row(
        children: [
          CustomTextLabel(
            text: "${index + 1}",
          ),
          getSizedBox(width: 5),
          const Icon(
            Icons.star_rounded,
            color: Colors.amber,
          ),
          getSizedBox(width: 5),
          Expanded(
            child: Container(
              height: 5,
              width: context.width * 0.4,
              decoration: BoxDecoration(
                color: ColorsRes.mainTextColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Container(
                  height: 5,
                  width: (context.width * 0.34) * ratingPercentage,
                  decoration: BoxDecoration(
                    color: ColorsRes.appColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          getSizedBox(width: 10),
          CustomTextLabel(
            text: "$totalRatings",
            style: TextStyle(
              color: ColorsRes.subTitleMainTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      getSizedBox(height: 10),
    ],
  );
}

double calculatePercentage(
    {required int totalRatings, required int starsWiseRatings}) {
  double percentage = 0.0;

  percentage = (starsWiseRatings * 100) / totalRatings;
  return percentage / 100;
}

// Widget getRatingReviewItem({required ProductRatingList rating}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsetsDirectional.only(
//               start: 5,
//             ),
//             decoration: BoxDecoration(
//               color: ColorsRes.appColor,
//               borderRadius: const BorderRadiusDirectional.all(
//                 Radius.circular(5),
//               ),
//             ),
//             child: Row(
//               children: [
//                 CustomTextLabel(
//                   text: rating.rate,
//                   style: TextStyle(
//                     color: ColorsRes.appColorWhite,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 15,
//                   ),
//                 ),
//                 const Icon(
//                   Icons.star_rate_rounded,
//                   color: Colors.amber,
//                   size: 20,
//                 )
//               ],
//             ),
//           ),
//           getSizedBox(width: 7),
//           CustomTextLabel(
//             text: rating.user?.name.toString() ?? "",
//             style: TextStyle(
//                 color: ColorsRes.mainTextColor,
//                 fontWeight: FontWeight.w800,
//                 fontSize: 15),
//             softWrap: true,
//           )
//         ],
//       ),
//       getSizedBox(height: 10),
//       if (rating.review.toString().length > 100)
//         ExpandableText(
//           text: rating.review.toString(),
//           max: 0.2,
//           color: ColorsRes.subTitleMainTextColor,
//         ),
//       if (rating.review.toString().length <= 100)
//         CustomTextLabel(
//           text: rating.review.toString(),
//           style: TextStyle(
//             color: ColorsRes.subTitleMainTextColor,
//           ),
//         ),
//       getSizedBox(height: 10),
//       if (rating.images != null && rating.images!.length > 0)
//         LayoutBuilder(
//           builder: (context, constraints) => Wrap(
//             runSpacing: 10,
//             spacing: constraints.maxWidth * 0.017,
//             children: List.generate(
//               rating.images!.length,
//               (index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(
//                         context, fullScreenProductImageScreen, arguments: [
//                       index,
//                       rating.images?.map((e) => e.imageUrl.toString()).toList()
//                     ]);
//                   },
//                   child: ClipRRect(
//                     borderRadius: Constant.borderRadius2,
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     child: setNetworkImg(
//                       image: rating.images?[index].imageUrl ?? "",
//                       width: 50,
//                       height: 50,
//                       boxFit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       getSizedBox(height: 10),
//       CustomTextLabel(
//         text: rating.updatedAt.toString().formatDate(),
//         style: TextStyle(
//           color: ColorsRes.subTitleMainTextColor,
//         ),
//         maxLines: 2,
//         softWrap: true,
//         overflow: TextOverflow.ellipsis,
//       ),
//     ],
//   );
// }

Widget DashedDivider({Color? color, double? height}) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final boxWidth = constraints.constrainWidth();
      const dashWidth = 5.0;
      final dashHeight = height;
      final dashCount = (boxWidth / (2 * dashWidth)).floor();
      return Flex(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: List.generate(dashCount, (_) {
          return SizedBox(
            width: dashWidth,
            height: dashHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: color ?? ColorsRes.subTitleMainTextColor),
            ),
          );
        }),
      );
    },
  );
}

Widget getHomeScreenShimmer(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: Constant.size10, horizontal: Constant.size10),
    child: Column(
      children: [
        CustomShimmer(
          height: context.height * 0.26,
          width: context.width,
        ),
        getSizedBox(
          height: Constant.size10,
        ),
        CustomShimmer(
          height: Constant.size10,
          width: context.width,
        ),
        getSizedBox(
          height: Constant.size10,
        ),
        getCategoryShimmer(
            context: context, count: 6, padding: EdgeInsets.zero),
        getSizedBox(
          height: Constant.size10,
        ),
        Column(
          children: List.generate(5, (index) {
            return Column(
              children: [
                const CustomShimmer(height: 50),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Constant.size10,
                            horizontal: Constant.size5),
                        child: CustomShimmer(
                          height: 210,
                          width: context.width * 0.4,
                        ),
                      );
                    }),
                  ),
                )
              ],
            );
          }),
        )
      ],
    ),
  );
}
