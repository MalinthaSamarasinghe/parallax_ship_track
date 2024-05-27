import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController textController;
  final FocusNode? focusNode;
  final bool isEnabled;
  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmitted;
  final bool? isValid;
  final String? errorText;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatter;
  final void Function()? onTap;
  final String? prefixIcon;
  final Color? prefixIconFillColor;

  const CustomTextField({
    super.key,
    this.isPassword = false,
    required this.hint,
    required this.textController,
    this.focusNode,
    this.isEnabled = true,
    this.onChanged,
    this.onSubmitted,
    this.isValid,
    this.errorText,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatter,
    this.onTap,
    this.prefixIcon,
    this.prefixIconFillColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = true;
  bool isValid = false;

  @override
  void initState() {
    if (widget.isValid != null) {
      isValid = widget.isValid!;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    if (widget.isValid != oldWidget.isValid) {
      isValid = widget.isValid!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 74.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 58.h,
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: TextFormField(
                      enabled: widget.isEnabled,
                      controller: widget.textController,
                      focusNode: widget.focusNode,
                      textCapitalization: widget.textCapitalization,
                      keyboardType: widget.keyboardType,
                      autofillHints: widget.autofillHints,
                      textInputAction: widget.textInputAction,
                      inputFormatters: widget.inputFormatter,
                      onChanged: (text) {
                        if (widget.onChanged != null) {
                          widget.onChanged!(text);
                        }
                      },
                      onFieldSubmitted: widget.onSubmitted,
                      onTap: widget.onTap,
                      textAlignVertical: TextAlignVertical.center,
                      style: kInter500(context, color: kFontColor, fontSize: 16.sp),
                      cursorColor: kFontHintColor,
                      decoration: InputDecoration(
                        isDense: true,
                        border: const UnderlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 2.h),
                        focusedBorder: const UnderlineInputBorder(),
                        disabledBorder: const UnderlineInputBorder(),
                        floatingLabelStyle: kInter400(context, color: kFontHintColor, fontSize: 16.sp),
                        labelStyle: kInter500(context, color: kFontHintColor, fontSize: 16.sp),
                        labelText: widget.hint,
                        prefixIcon: widget.prefixIcon != null
                            ? widget.prefixIcon!.endsWith('.svg')
                              ? Container(
                                  padding: EdgeInsets.only(right: 10.w, top: 12.h, bottom: 12.h),
                                  height: 4.w,
                                  width: 4.w,
                                  child: SvgPicture.asset(
                                    widget.prefixIcon!,
                                    colorFilter: ColorFilter.mode(widget.prefixIconFillColor ?? kFontColor, BlendMode.srcIn),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.only(right: 11.w, top: 10.h, bottom: 10.h),
                                  clipBehavior: Clip.none,
                                  child: Image.asset(
                                    widget.prefixIcon!,
                                    width: 8.w,
                                    height: 8.w,
                                    color: widget.prefixIconFillColor ?? kFontColor,
                                  ),
                                )
                            : null,
                        suffixIcon: widget.isPassword
                            ? GestureDetector(
                                onTap: _toggleVisibility,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(8.w, 12.h, 0.w, 12.h),
                                  child: isHidden
                                      ? Image.asset("assets/images/hidden.png", width: 20.w, height: 20.w, color: kFontColor)
                                      : Image.asset("assets/images/show.png", width: 20.w, height: 20.w, color: kFontColor),
                                ),
                              )
                            : null,
                      ),
                      obscureText: widget.isPassword ? isHidden : false,
                      obscuringCharacter: '●',
                    ),
                  ),
                ),
              ],
            ),
          ),
          widget.errorText == null
              ? const SizedBox()
              : Positioned(
                  bottom: 4.h,
                  left: 18.w,
                  right: 18.w,
                  child: Text(
                    widget.errorText ?? '',
                    style: kInter400(context, color: kColorRed, fontSize: 12.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
        ],
      ),
    );
  }

  _toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}
