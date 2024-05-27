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
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          child: Ink(
            width: double.infinity,
            height: height ?? 45.h,
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
                  ? const [
                      BoxShadow(
                        color: kColorLightBlue,
                        offset: Offset(0, 4),
                        blurRadius: 20,
                        spreadRadius: 5,
                      )
                    ]
                  : null,
            ),
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
        ),
      ),
    );
  }
}
