import '../../utils/font.dart';
import '../../utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Function()? onLeadingPress;
  final Function()? onTrailingPress;

  const ScreenAppBar({
    super.key,
    this.title = '',
    this.onLeadingPress,
    this.onTrailingPress,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.5);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: kColorWhite,
      surfaceTintColor: kColorWhite,
      shadowColor: kColorWhite,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      title: Padding(
        padding: EdgeInsets.only(top: 15.h),
        child: AutoSizeText(
          title ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          minFontSize: 20,
        ),
      ),
      titleTextStyle: kInter700(context, fontSize: 20.sp),
      leading: Padding(
        padding: EdgeInsets.only(top: 12.h, left: 15.w),
        child: IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 25.sp,
          onPressed: onLeadingPress,
          color: kColorBlack,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: 11.h, right: 15.w),
          child: IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            iconSize: 25.sp,
            onPressed: onTrailingPress,
            color: kColorBlack,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
