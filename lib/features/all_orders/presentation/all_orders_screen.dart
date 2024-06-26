import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/font.dart';
import 'bloc/all_orders_bloc.dart';
import '../../../utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../map/presentation/map_screen.dart';
import '../../../core/presentation/screen_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../order_details/presentation/order_details_view.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../order_details/presentation/order_details_tab_view.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_database;

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  late final StreamSubscription<firebase_database.DatabaseEvent> allOrdersDataSubscription;

  @override
  void initState() {
    firebase_auth.FirebaseAuth.instance.currentUser?.reload();
    allOrdersDataSubscription = getAllOrdersData().listen((data) {
      context.read<AllOrdersBloc>().add(AllOrdersChanged(data));
    }, onError: (error) {
      debugPrint("Error in data stream: $error");
    });
    super.initState();
  }

  @override
  void dispose() {
    allOrdersDataSubscription.cancel();
    super.dispose();
  }

  Stream<firebase_database.DatabaseEvent> getAllOrdersData() {
    return firebase_database.FirebaseDatabase.instance.ref('Orders').onValue.map((firebaseData) {
      return firebaseData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: ScreenAppBar(
          title: 'My Orders',
          onTrailingPress: () { },
          onLeadingPress: () { },
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: kDashboardColor,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<AllOrdersBloc, AllOrdersState>(
              buildWhen: (prev, current) {
                if (prev.status == AllOrdersStatus.initial && current.status == AllOrdersStatus.loading) {
                  return false;
                } else {
                  return true;
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                            iconSize: 20.r,
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            color: kColorBlack,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                          Expanded(
                            child: Text(
                              'All Statistics',
                              style: kInter500(context, fontSize: 16.sp),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.file_download_outlined),
                            iconSize: 24.r,
                            /// TODO: Implement download functionality
                            onPressed: (){ },
                            color: kColorBlack,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: ListView.builder(
                        itemCount: 7,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              // _showOrderView();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return BlocProvider.value(
                                      value: BlocProvider.of<AllOrdersBloc>(context),
                                      child: MapScreenWrapper(orderCurrentLocationData: LatLng(6.907579, 79.899033)
                                    ),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: 57.h,
                              width: double.maxFinite,
                              padding: EdgeInsets.only(left: 16.w, right: 10.w),
                              margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: kColorWhite,
                                boxShadow: [
                                  BoxShadow(
                                    color: kDividerColor.withOpacity(0.5),
                                    offset: const Offset(1, 4),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'CFC006030$index',
                                      style: kMontserrat500(context, fontSize: 14.sp),
                                    ),
                                  ),
                                  Container(
                                    width: 100.w,
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: index.isOdd ? kColorRed.withOpacity(0.2) : kIndicatorColor.withOpacity(0.3),
                                    ),
                                    child: Text(
                                      index.isOdd ? 'Completed' : 'Cancelled',
                                      style: kInter500(context, color: index.isOdd ? kColorRed : kColorBlue, fontSize: 14.sp),
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  GestureDetector(
                                    onTap: () {
                                      _showOrderFullDetailsView();
                                    },
                                    child: Icon(
                                      Icons.more_vert_outlined,
                                      size: 24.r,
                                      color: kFontColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 45.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showOrderView() {
    showDialog<String>(
      context: context,
      barrierColor: kDialogBgColor.withOpacity(0.3),
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<AllOrdersBloc>(context),
          child: const OrderDetailsView(),
        );
      },
    );
  }

  void _showOrderFullDetailsView() {
    showDialog<String>(
      context: context,
      barrierColor: kDialogBgColor.withOpacity(0.3),
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<AllOrdersBloc>(context),
          child: const OrderDetailsTabView(),
        );
      },
    );
  }
}
