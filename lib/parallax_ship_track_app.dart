import 'injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/presentation/custom_snack_bar.dart';
import 'core/blocs/authentication/auth_bloc.dart';
import 'features/login/presentation/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class ParallaxShipTrackAppWrapper extends StatelessWidget {
  const ParallaxShipTrackAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        ),
      ],
      child: const ParallaxShipTrackApp(),
    );
  }
}

class ParallaxShipTrackApp extends StatefulWidget {
  const ParallaxShipTrackApp({super.key});

  @override
  State<ParallaxShipTrackApp> createState() => _ParallaxShipTrackAppState();
}

class _ParallaxShipTrackAppState extends State<ParallaxShipTrackApp> {
  bool navigatedToNextScreen = false;

  @override
  Widget build(BuildContext context) {
    /// Remove the splash screen
    FlutterNativeSplash.remove();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, info) {
        return MaterialApp(
          builder: (context, child) {
            child = EasyLoading.init()(context, child);
            return ScrollConfiguration(
              behavior: AppBehavior(),
              child: child,
            );
          },
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Parallax Ship Track',
          theme: ThemeData(
            scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all(Colors.transparent),
              thickness: MaterialStateProperty.all(0),
              trackColor: MaterialStateProperty.all(Colors.transparent),
            ),
          ),
          home: ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, child) {
              return BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  _authListener(context, state);
                },
                listenWhen: (previous, current) {
                  return previous.authenticationStatus != current.authenticationStatus;
                },
                buildWhen: (previous, current) {
                  return !navigatedToNextScreen;
                },
                builder: (context, state) {
                  return _getNavigateNextScreen(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  /// Navigate to next screen base on user authentication
  Widget _getNavigateNextScreen(BuildContext context) {
    navigatedToNextScreen = true;
    switch (context.read<AuthBloc>().state.authenticationStatus) {
      case AuthStatus.authenticated:
        return const DashboardScreenWrapper();
      default:
        return const LoginScreenWrapper();
    }
  }

  /// User will redirect to the login screen when the user session expired or user logout
  Future<void> _authListener(BuildContext context, AuthState state) async {
    switch (state.authenticationStatus) {
      case AuthStatus.authenticated:
        {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreenWrapper()), (route) => route.isFirst,
          );
        }
        break;
      case AuthStatus.unauthenticated:
        {
          EasyLoading.dismiss();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreenWrapper()), (route) => route.isFirst,
          );
        }
        break;
      case AuthStatus.sessionExpired:
        {
          EasyLoading.dismiss();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreenWrapper()), (route) => route.isFirst,
          );
          Future.delayed(const Duration(milliseconds: 100), () {
            CustomSnackBar().showSnackBar(
              context,
              title: 'Error',
              msg: 'Session Expired! Please log in again.',
              snackBarTypes: SnackBarTypes.error,
            );
          });
        }
        break;
      case AuthStatus.accountDeleted:
        {
          EasyLoading.dismiss();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreenWrapper()), (route) => route.isFirst,
          );
          Future.delayed(const Duration(milliseconds: 100), () {
            CustomSnackBar().showSnackBar(
              context,
              title: 'Error',
              msg: 'Account Deleted Successfully! If you wish to continue using our services, please create a new account.',
              snackBarTypes: SnackBarTypes.error,
            );
          });
        }
        break;
      default:
        {
          EasyLoading.dismiss();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreenWrapper()), (route) => route.isFirst,
          );
          Future.delayed(const Duration(milliseconds: 100), () {
            CustomSnackBar().showSnackBar(
              context,
              title: 'Error',
              msg: 'Oops something went wrong! Please log in again.',
              snackBarTypes: SnackBarTypes.error,
            );
          });
        }
    }
  }
}

/// To remove scroll glow
class AppBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
