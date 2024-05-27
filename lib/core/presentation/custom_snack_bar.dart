import '../../utils/font.dart';
import '../../utils/colors.dart';
import 'buttons/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackBar {
  showSnackBar(
    BuildContext context, {
    required String title,
    required String msg,
    required SnackBarTypes snackBarTypes,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      width: double.infinity,
      animation: CurvedAnimation(
        parent: AnimationController(
          duration: const Duration(milliseconds: 100),
          vsync: ScaffoldMessenger.of(context),
        ),
        curve: Curves.ease,
      ),
      content: CustomSnackBarContent(
        title: title,
        message: msg,
        snackBarTypes: snackBarTypes,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

class CustomSnackBarContent extends StatelessWidget {
  final String title;
  final String message;
  final SnackBarTypes snackBarTypes;

  const CustomSnackBarContent({
    super.key,
    required this.title,
    required this.message,
    required this.snackBarTypes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.only(left: 26.w, right: 7.1.w),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: snackBarTypes.color,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [BoxShadow(color: kShadowColor, offset: Offset(0, 0), blurRadius: 24, spreadRadius: 0)],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                SizedBox(height: 7.h),
                CircleButton(
                  height: 20.7.w,
                  width: 20.7.w,
                  icon: Center(
                    child: Icon(Icons.close_rounded, size: 16.r, color: kColorBlack),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 19.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 0.1.w),
                    SvgPicture.asset(
                      'assets/svg/error_warning.svg',
                      width: 24.w,
                      height: 24.w,
                      colorFilter: const ColorFilter.mode(kColorWhite, BlendMode.srcIn),
                    ),
                    SizedBox(width: 7.5.w),
                    SizedBox(
                      width: 290.w,
                      child: AutoSizeText(
                        title,
                        style: kInter500(context, color: kColorWhite, fontSize: 16.sp),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        minFontSize: 16,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.5.h),
                SizedBox(
                  width: 330.w,
                  child: Padding(
                    padding:  EdgeInsets.only(left: 2.w),
                    child: AutoSizeText(
                      message,
                      style: kInter400(context, color: kColorWhite, fontSize: 14.sp),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      minFontSize: 14,
                      maxLines: 2,
                    ),
                  ),
                ),
                SizedBox(height: 23.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SnackBarTypes {
  final String message;
  final Color? color;

  SnackBarTypes(this.message, [this.color]);

  static SnackBarTypes error = SnackBarTypes('Error', kColorRed);
  static SnackBarTypes alert = SnackBarTypes('Alert', kColorDarkBlue);
}
