import 'bloc/login_bloc.dart';
import '../../../injector.dart';
import 'package:formz/formz.dart';
import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../signup/presentation/signup_screen.dart';
import '../../../core/presentation/custom_snack_bar.dart';
import '../../../core/blocs/authentication/auth_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/presentation/buttons/main_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../core/models/form_inputs/email_formz_model.dart';
import '../../../core/models/form_inputs/common_formz_model.dart';
import '../../../core/presentation/textfields/custom_textfield.dart';
import '../../forgot_password/presentation/forgot_password_screen.dart';

class LoginScreenWrapper extends StatelessWidget {
  const LoginScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => sl<LoginBloc>(),
        ),
      ],
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = true;

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
                  /// Email Address TextField
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BlocSelector<LoginBloc, LoginState, EmailFormzModel>(
                      selector: (state) {
                        return state.email;
                      },
                      builder: (context, email) {
                        return CustomTextField(
                          hint: 'Enter your email',
                          prefixIcon: 'assets/images/mail.png',
                          textController: context.read<LoginBloc>().emailController,
                          focusNode: context.read<LoginBloc>().emailNode,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          onChanged: (text) {
                            context.read<LoginBloc>().add(EmailChanged(text.trim()));
                          },
                          onSubmitted: (text) {
                            FocusScope.of(context).requestFocus(context.read<LoginBloc>().passwordNode);
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
                    child: BlocSelector<LoginBloc, LoginState, CommonFormzModel>(
                      selector: (state) {
                        return state.password;
                      },
                      builder: (context, password) {
                        return CustomTextField(
                          hint: 'Enter your password',
                          prefixIcon: 'assets/images/lock.png',
                          textController: context.read<LoginBloc>().passwordController,
                          focusNode: context.read<LoginBloc>().passwordNode,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.visiblePassword,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          isPassword: true,
                          onChanged: (text) {
                            context.read<LoginBloc>().add(PasswordChanged(text.trim()));
                          },
                          onSubmitted: (text) {},
                          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                          isValid: password.isValid,
                          errorText: password.isPure ? null : password.error?.message,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 45.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_rememberMe) {
                            _rememberMe = false;
                          } else {
                            _rememberMe = true;
                          }
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Check Box
                          Icon(
                            _rememberMe ? Icons.check_box_outline_blank_outlined : Icons.check_box_outlined,
                            color: _rememberMe ? kFontColor : kFontColor,
                            size: 18.r,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 14.w),
                            child: Text(
                              'Remember Me',
                              style: kInter500(context, color: kFontColor, fontSize: 16.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  /// Login Button
                  BlocConsumer<LoginBloc, LoginState>(
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
                      }
                      if (state.status == FormzSubmissionStatus.inProgress) {
                        EasyLoading.show(status: "Please Wait", dismissOnTap: false);
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    builder: (context, state) {
                      return MainButton(
                        title: 'Log In',
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<LoginBloc>().add(const PasswordLoginRequested(loginStatus: LoginStatus.loginInitial));
                        },
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  /// Forgot password
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Forgot password?",
                              style: kInter500(context, color: kForgotTxtColor, fontSize: 16.sp),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ForgotPasswordScreenWrapper()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  /// Don't have an account?
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account?",
                              style: kInter500(context, color: kForgotTxtColor, fontSize: 16.sp),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignUpScreenWrapper()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/login_gif.gif',
                    height: 227.h,
                    width: 248.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
