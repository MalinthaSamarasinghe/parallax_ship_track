import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../injector.dart';
import 'widgets/google_map.dart';
import '../../../utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/error_box.dart';
import '../../../core/presentation/screen_app_bar.dart';
import 'bloc/current_location/current_location_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapScreenWrapper extends StatelessWidget {
  final LatLng orderCurrentLocationData;

  const MapScreenWrapper({super.key, required this.orderCurrentLocationData});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrentLocationBloc>(
          create: (context) => sl<CurrentLocationBloc>()..add(CurrentLocationRequested()),
        ),
      ],
      child: MapScreen(orderCurrentLocationData: orderCurrentLocationData),
    );
  }
}

class MapScreen extends StatelessWidget {
  final LatLng orderCurrentLocationData;

  const MapScreen({super.key, required this.orderCurrentLocationData});

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
                    padding: EdgeInsets.only(top: 20.h),
                    child: ErrorBox(
                      /// TODO: NEED TO HANDLE PERMISSION DENIED ERROR Correct "Instance of 'NoPermission'"
                      title: '',
                      outerPadding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 12.h),
                      description: state.failureMessage ?? "Data Fetch Failed!",
                      descriptionMaxLines: 5,
                    ),
                  ),
                );
              } else if (state.currentLocationData == null) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: ErrorBox(
                      title: '',
                      outerPadding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 12.h),
                      description: state.failureMessage ?? "Data Fetch Failed!",
                      descriptionMaxLines: 5,
                    ),
                  ),
                );
              } else {
                return GoogleMapWidget(
                  userCurrentLocationData: state.currentLocationData!,
                  orderCurrentLocationData: orderCurrentLocationData,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
