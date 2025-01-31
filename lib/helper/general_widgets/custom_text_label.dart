import 'package:every_home_flutter/helper/utils/general_imports.dart';

class CustomTextLabel extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final int? lines;
  final TextOverflow? overflow;
  final bool? softWrap;

  const CustomTextLabel({
    super.key,
    this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: style ?? TextStyle(color: ColorsRes.mainTextColor),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap ?? true,
    );
  }
}
