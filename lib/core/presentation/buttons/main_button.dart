import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButton extends StatelessWidget {
  final double? height;
  final bool hasBoxShadow;
  final bool hasBorderColor;
  final Color? borderColor;
  final String? title;
  final Color? titleColor;
  final Function() onPressed;
  final bool isInProgress;

  const MainButton({
    super.key,
    this.height,
    this.hasBoxShadow = true,
    this.hasBorderColor = false,
    this.borderColor,
    this.title,
    this.titleColor,
    required this.onPressed,
    this.isInProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 45.h,
      margin: EdgeInsets.symmetric(horizontal: 37.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [kColorDarkBlue, kColorLightBlue],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        border: hasBorderColor
            ? Border.all(color: borderColor ?? kColorWhite, width: 1.w)
            : null,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: hasBoxShadow
            ? [
                BoxShadow(
                  color: kColorDarkBlue.withOpacity(0.5),
                  offset: const Offset(2, 2),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: isInProgress
              ? const CircularProgressIndicator()
              : AutoSizeText(
                  title!,
                  style: kInter500(context, color: titleColor ?? kColorWhite),
                  textAlign: TextAlign.center,
                  minFontSize: 16,
                ),
        ),
      ),
    );
  }
}
