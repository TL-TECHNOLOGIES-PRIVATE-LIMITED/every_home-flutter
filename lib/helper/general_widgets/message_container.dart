import 'package:every_home_flutter/helper/utils/general_imports.dart';

Widget MessageContainer({
  required BuildContext context,
  required String text,
  required MessageType type,
}) {
  return Material(
    color: Theme.of(context).scaffoldBackgroundColor,
    child: ToastAnimation(
      delay: Constant.messageDisplayDuration,
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            // using gradient to apply one side dark color in container
            gradient: LinearGradient(
              stops: const [0.02, 0.02],
              colors: [
                messageColors[type]!,
                messageColors[type]!.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: messageColors[type]!.withOpacity(0.5),
            ),
          ),
          width: context.width,
          constraints: const BoxConstraints(minHeight: 50),
          child: Row(
            children: [
              getSizedBox(width: 15),
              messageIcon[type]!,
              SizedBox(
                width: context.width - 90,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextLabel(
                    text: text,
                    softWrap: true,
                    style: TextStyle(
                      color: messageColors[type],
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              getSizedBox(width: 10),
            ],
          )),
    ),
  );
}
