import 'package:flutter/cupertino.dart';

import '../../../injector.dart';
import 'package:formz/formz.dart';
import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'bloc/forgot_password_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/custom_snack_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/presentation/buttons/main_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/presentation/buttons/circle_button.dart';
import '../../../core/models/form_inputs/email_formz_model.dart';
import '../../../core/presentation/textfields/custom_textfield.dart';

class ForgotPasswordScreenWrapper extends StatelessWidget {
  const ForgotPasswordScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ForgotPasswordBloc>(
          create: (context) => sl<ForgotPasswordBloc>(),
        ),
      ],
      child: const ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: kColorWhite,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 90.h),
                  /// Logo
                  Image.asset(
                    "assets/images/app_logo.png",
                    width: 123.w,
                    height: 123.w,
                    color: kLogoColor,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 26.h),
                  /// Forgot password?
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 37.w),
                      child: Text(
                        "Forgot password?",
                        style: kInter600(context, fontSize: 16.sp),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  /// Reset password to continue enjoying your personalized journey.
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 37.w),
                    child: Text(
                      "Enter your email and we'll send you instructions to reset your password",
                      style: kInter400(context, fontSize: 12.sp),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  /// Email Address TextField
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BlocSelector<ForgotPasswordBloc, ForgotPasswordState, EmailFormzModel>(
                      selector: (state) {
                        return state.email;
                      },
                      builder: (context, email) {
                        return CustomTextField(
                          hint: 'Email',
                          prefixIcon: 'assets/images/mail.png',
                          textController: context.read<ForgotPasswordBloc>().emailController,
                          focusNode: context.read<ForgotPasswordBloc>().emailNode,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          onChanged: (text) {
                            context.read<ForgotPasswordBloc>().add(ForgotEmailRequested(text.trim()));
                          },
                          onSubmitted: (text) { },
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                          isValid: email.isValid,
                          errorText: email.isPure ? null : email.error?.message,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),
                  /// Submit Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 37.w),
                    child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                      listener: (context, state) {
                        if (state.status == FormzSubmissionStatus.failure) {
                          EasyLoading.dismiss();
                          FocusManager.instance.primaryFocus?.unfocus();
                          Future.delayed(const Duration(milliseconds: 100), () {
                            CustomSnackBar().showSnackBar(
                              context,
                              title: 'Error',
                              msg: state.errorMessage ?? 'Something went wrong. Please try again later.',
                              snackBarTypes: SnackBarTypes.error,
                            );
                          });
                        }
                        if (state.status == FormzSubmissionStatus.success) {
                          EasyLoading.dismiss();
                          FocusManager.instance.primaryFocus?.unfocus();
                          Future.delayed(const Duration(milliseconds: 100), () {
                            CustomSnackBar().showSnackBar(
                              context,
                              title: 'Success',
                              msg: state.successMessage ?? 'Password reset link sent to ${state.email.value}. Please check your ${state.email.value} to reset your password.',
                              snackBarTypes: SnackBarTypes.alert,
                            );
                          });
                          Navigator.pop(context);
                        }
                        if (state.status == FormzSubmissionStatus.inProgress) {
                          EasyLoading.show(status: "Please Wait", dismissOnTap: false);
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                      builder: (context, state) {
                        return MainButton(
                          title: 'Submit',
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            context.read<ForgotPasswordBloc>().add(const ForgotPasswordLinkRequested());
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
