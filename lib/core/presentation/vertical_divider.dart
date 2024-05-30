import '../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalDividerContainer extends StatelessWidget {
  final Color? color;

  const VerticalDividerContainer({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: color ?? kDividerColor,
      thickness: 0.30.h,
      width: 0.1.h,
    );
  }
}
