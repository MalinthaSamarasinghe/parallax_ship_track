import '../../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? icon;
  final Function()? onTap;
  final Decoration? btnDecoration;
  final Color? iconColor;
  final Color? bgColor;
  final String title;

  const CircleButton({
    super.key,
    this.width,
    this.height,
    this.icon,
    this.onTap,
    this.btnDecoration,
    this.bgColor,
    this.iconColor,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: btnDecoration ?? const BoxDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            child: Ink(
              width: width ?? 44.w,
              height: height ?? 44.w,
              decoration: BoxDecoration(
                color: bgColor ?? kColorWhite,
                shape: BoxShape.circle,
              ),
              child: icon ?? Icon(Icons.close, color: iconColor ?? kColorBlack),
            ),
          ),
        ),
      ),
    );
  }
}
