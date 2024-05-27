import 'dart:async';
import 'injector.dart';
import 'firebase_options.dart';
import 'parallax_ship_track_app.dart';
import 'core/blocs/bloc_observer.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'core/other/config_easy_loader.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      await EasyLocalization.ensureInitialized();

      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      /// Initialize service locator
      await setupLocators();

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      );

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      /// Set theme for EasyLoader indicator
      ConfigEasyLoader.darkTheme();

      /// Setup global observer to monitor all blocs
      Bloc.observer = ParallaxShipTrackBlocObserver();

      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory(),
      );

      runApp(
        EasyLocalization(
          supportedLocales: const [
            Locale('en', 'US'),
          ],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const ParallaxShipTrackAppWrapper(),
        ),
      );
    },
    (error, stack) {
      debugPrint("runZonedGuarded: Caught error in my root zone. $error");
      if (!kDebugMode) {
        debugPrint("#1113 error $error | stack $stack");
      }
    },
  );
}
