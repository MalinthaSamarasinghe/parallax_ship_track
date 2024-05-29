import '../../utils/font.dart';
import '../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorBox extends StatelessWidget {
  final AlignmentGeometry alignment;
  final String? title;
  final TextStyle? titleStyle;
  final String? description;
  final TextStyle? descriptionStyle;
  final String svgImage;
  final int svgSize;
  final EdgeInsets? innerPadding;
  final EdgeInsets? outerPadding;
  final Color? bgColor;
  final int radius;
  final double titleMinFontSize;
  final int? titleMaxLines;
  final double descriptionMinFontSize;
  final int? descriptionMaxLines;
  final double? height;

  const ErrorBox({
    super.key,
    this.title = '',
    this.alignment = Alignment.topCenter,
    this.titleStyle,
    this.description = '',
    this.descriptionStyle,
    this.svgImage = 'assets/svg/sad_icon.svg',
    this.svgSize = 25,
    this.innerPadding,
    this.outerPadding,
    this.bgColor,
    this.radius = 10,
    this.titleMinFontSize = 23,
    this.titleMaxLines = 10,
    this.descriptionMinFontSize = 13,
    this.descriptionMaxLines = 1,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: double.infinity,
        height: height,
        margin: outerPadding ?? EdgeInsets.zero,
        padding: innerPadding ?? EdgeInsets.symmetric(horizontal: 47.w, vertical: 28.h),
        decoration: BoxDecoration(
          color: bgColor ?? kDividerColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(radius.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: height != null ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(svgImage, width: svgSize.w, height: svgSize.w),
            title == null || title!.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: AutoSizeText(
                      title!,
                      style: titleStyle ?? kInter500(context, fontSize: 23.sp),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: titleMinFontSize,
                      maxLines: titleMaxLines,
                    ),
                  ),
            description == null || description!.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.only(top: title == null || title!.isEmpty ? 15.h : 30.h),
                    child: AutoSizeText(
                      description!,
                      style: descriptionStyle ?? kInter400(context, fontSize: 13.sp),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: descriptionMinFontSize,
                      maxLines: descriptionMaxLines,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
