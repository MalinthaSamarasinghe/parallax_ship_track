import '../../../injector.dart';
import '../../../utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/error_box.dart';
import '../../../core/presentation/screen_app_bar.dart';
import 'bloc/current_location/current_location_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapScreenWrapper extends StatelessWidget {
  const MapScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentLocationBloc>(
          create: (context) => sl<CurrentLocationBloc>()..add(CurrentLocationRequested()),
        ),
      ],
      child: const MapScreen(),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: ScreenAppBar(
          title: 'Map',
          onTrailingPress: () { },
          onLeadingPress: () { },
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: kDashboardColor,
          child: BlocBuilder<CurrentLocationBloc, CurrentLocationState>(
            buildWhen: (prev, current) {
              if (prev.status == CurrentLocationStatus.initial && current.status == CurrentLocationStatus.loading) {
                return false;
              } else {
                return true;
              }
            },
            builder: (context, state) {
              if (state.status == CurrentLocationStatus.initial || state.status == CurrentLocationStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == CurrentLocationStatus.failure) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 120.h),
                    child: ErrorBox(
                      /// TODO: NEED TO HANDLE PERMISSION DENIED ERROR Correct "Instance of 'NoPermission'"- Malintha
                      title: '${state.failureMessage}',
                      outerPadding: EdgeInsets.only(top: 88.h, left: 22.w, right: 22.w),
                      description: state.failureMessage ?? "Data Fetch Failed!",
                    ),
                  ),
                );
              } else if (state.currentLocationData == null) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 120.h),
                    child: ErrorBox(
                      title: 'No permission granted!',
                      outerPadding: EdgeInsets.only(top: 88.h, left: 22.w, right: 22.w),
                      description: state.failureMessage ?? "Data Fetch Failed!",
                    ),
                  ),
                );
              } else {
                // return GoogleMapWidget(userCurrentLocationData: state.currentLocationData!);
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
