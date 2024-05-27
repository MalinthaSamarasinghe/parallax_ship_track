import '../../../injector.dart';
import 'bloc/sign_up_bloc.dart';
import '../../../utils/font.dart';
import 'package:formz/formz.dart';
import '../../../utils/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/custom_snack_bar.dart';
import '../../../core/blocs/authentication/auth_bloc.dart';
import '../../profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/presentation/buttons/main_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/models/form_inputs/name_form_model.dart';
import '../../../core/models/form_inputs/email_formz_model.dart';
import '../../../core/models/form_inputs/password_formz_model.dart';
import '../../../core/presentation/textfields/custom_textfield.dart';

class SignUpScreenWrapper extends StatelessWidget {
  const SignUpScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          create: (context) => sl<SignUpBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => sl<ProfileBloc>(),
        ),
      ],
      child: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
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
                  SizedBox(height: 60.h),
                  /// Logo
                  Image.asset(
                    "assets/images/app_logo.png",
                    width: 123.w,
                    height: 123.w,
                    color: kLogoColor,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20.h),
                  /// Name TextField
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BlocSelector<SignUpBloc, SignUpState, NameFormzModel>(
                      selector: (state) {
                        return state.name;
                      },
                      builder: (context, name) {
                        return CustomTextField(
                          hint: 'Name',
                          prefixIcon: 'assets/images/user.png',
                          textController: context.read<SignUpBloc>().nameController,
                          focusNode: context.read<SignUpBloc>().nameNode,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          autofillHints: const [AutofillHints.username],
                          textInputAction: TextInputAction.next,
                          onChanged: (text) {
                            context.read<SignUpBloc>().add(GetNameChanged(text.trim()));
                          },
                          onSubmitted: (text) {
                            FocusScope.of(context).requestFocus(context.read<SignUpBloc>().emailNode);
                          },
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                          isValid: name.isValid,
                          errorText: name.isPure ? null : name.error?.message,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 2.h),
                  /// Email Address TextField
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BlocSelector<SignUpBloc, SignUpState, EmailFormzModel>(
                      selector: (state) {
                        return state.email;
                      },
                      builder: (context, email) {
                        return CustomTextField(
                          hint: 'Email',
                          prefixIcon: 'assets/images/mail.png',
                          textController: context.read<SignUpBloc>().emailController,
                          focusNode: context.read<SignUpBloc>().emailNode,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          onChanged: (text) {
                            context.read<SignUpBloc>().add(GetEmailChanged(text.trim()));
                          },
                          onSubmitted: (text) {
                            FocusScope.of(context).requestFocus(context.read<SignUpBloc>().passwordNode);
                          },
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                          isValid: email.isValid,
                          errorText: email.isPure ? null : email.error?.message,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 2.h),
                  /// Password TextField
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BlocSelector<SignUpBloc, SignUpState, PasswordFormzModel>(
                      selector: (state) {
                        return state.password;
                      },
                      builder: (context, password) {
                        return CustomTextField(
                          hint: 'Password',
                          prefixIcon: 'assets/images/lock.png',
                          textController: context.read<SignUpBloc>().passwordController,
                          focusNode: context.read<SignUpBloc>().passwordNode,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.visiblePassword,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          isPassword: true,
                          onChanged: (text) {
                            context.read<SignUpBloc>().add(GetPasswordChanged(text.trim(), context.read<SignUpBloc>().confirmedPasswordController.text.trim()));
                            if(context.read<SignUpBloc>().confirmedPasswordController.text != ''){
                              context.read<SignUpBloc>().add(GetConfirmedPasswordChanged(context.read<SignUpBloc>().confirmedPasswordController.text.trim(), text.trim()));
                            }
                          },
                          onSubmitted: (text) {
                            FocusScope.of(context).requestFocus(context.read<SignUpBloc>().confirmedPasswordNode);
                          },
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                          isValid: password.isValid,
                          errorText: password.isPure ? null : password.error?.message,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 2.h),
                  /// Confirm Password TextField
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BlocSelector<SignUpBloc, SignUpState, PasswordFormzModel>(
                      selector: (state) {
                        return state.confirmedPassword;
                      },
                      builder: (context, confirmedPassword) {
                        return CustomTextField(
                          hint: 'Confirm Password',
                          prefixIcon: 'assets/images/lock.png',
                          textController: context.read<SignUpBloc>().confirmedPasswordController,
                          focusNode: context.read<SignUpBloc>().confirmedPasswordNode,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.visiblePassword,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          isPassword: true,
                          onChanged: (text) {
                            context.read<SignUpBloc>().add(GetConfirmedPasswordChanged(text.trim(), context.read<SignUpBloc>().passwordController.text.trim()));
                            if(context.read<SignUpBloc>().passwordController.text != ''){
                              context.read<SignUpBloc>().add(GetPasswordChanged(context.read<SignUpBloc>().passwordController.text.trim(), text.trim()));
                            }
                          },
                          onSubmitted: (text) {},
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                          isValid: confirmedPassword.isValid,
                          errorText: confirmedPassword.isPure ? null : confirmedPassword.error?.message,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  /// Sign Up Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 37.w),
                    child: BlocConsumer<SignUpBloc, SignUpState>(
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
                          context.read<AuthBloc>().add(LoggedIn(authenticationStatus: AuthStatus.authenticated, user: state.userCredential!.user!));
                          context.read<ProfileBloc>().add(UpdateNameChanged(name: state.name.value));
                          context.read<ProfileBloc>().add(const UpdateProfileImgChanged(profileImg: 'https://w7.pngwing.com/pngs/177/551/png-transparent-user-interface-design-computer-icons-default-stephen-salazar-graphy-user-interface-design-computer-wallpaper-sphere.png'));
                        }
                        if (state.status == FormzSubmissionStatus.inProgress) {
                          EasyLoading.show(status: "Please Wait", dismissOnTap: false);
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                      builder: (context, state) {
                        return MainButton(
                          title: 'Sign Up',
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            context.read<SignUpBloc>().add(const GetAccountCreationRequested());
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  /// Forgot password
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account?",
                              style: kInter500(context, color: kForgotTxtColor, fontSize: 16.sp),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
