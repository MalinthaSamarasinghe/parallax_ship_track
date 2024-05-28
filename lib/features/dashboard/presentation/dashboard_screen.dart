import 'dart:async';
import '../../../injector.dart';
import '../../../utils/font.dart';
import 'bloc/dashboard_bloc.dart';
import '../../../utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/screen_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../status_statistics/presentation/status_statistics_screen.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_database;

class DashboardScreenWrapper extends StatelessWidget {
  const DashboardScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (context) => sl<DashboardBloc>(),
        ),
      ],
      child: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final StreamSubscription<firebase_database.DatabaseEvent> dataSubscription;
  String userUid = 'unknown_uid';

  @override
  void initState() {
    firebase_auth.FirebaseAuth.instance.currentUser?.reload();
    userUid = firebase_auth.FirebaseAuth.instance.currentUser?.uid ?? 'unknown_uid';
    dataSubscription = getData(userUid).listen((data) {
      context.read<DashboardBloc>().add(DashboardDataChanged(data));
    }, onError: (error) {
      debugPrint("Error in data stream: $error");
    });
    super.initState();
  }

  @override
  void dispose() {
    dataSubscription.cancel();
    super.dispose();
  }

  Stream<firebase_database.DatabaseEvent> getData(String uid) {
    return firebase_database.FirebaseDatabase.instance.ref('result/$uid').onValue.map((firebaseData) {
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
          title: 'Dashboard',
          onTrailingPress: () { },
          onLeadingPress: () { },
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: kDashboardColor,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: BlocBuilder<DashboardBloc, DashboardState>(
              buildWhen: (prev, current) {
                if (prev.status == DashboardStatus.initial && current.status == DashboardStatus.loading) {
                  return false;
                } else {
                  return true;
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    /// Orders Statistics
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          Text(
                            'Orders Statistics',
                            style: kInter500(context, fontSize: 16.sp),
                          ),
                          SizedBox(height: 8.h),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.all(20.w),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 105.h,
                                crossAxisCount: 2,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 12.h,
                              ),
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () { },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 45.w,
                                        height: 45.w,
                                        child: Center(
                                          child: Image.asset(
                                            "assets/images/order_count.png",
                                            width: 45.w,
                                            height: 45.w,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 8.h),
                                          SizedBox(
                                            width: 90.w,
                                            child: Text(
                                              "234.1k",
                                              style: kInter800(context, fontSize: 24.sp),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          SizedBox(
                                            width: 90.w,
                                            child: Text(
                                              "Total Delivery Charge",
                                              style: kInter500(context, color: kFontColor, fontSize: 16.sp, height: 1.h),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    /// Finance Statistics
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          Text(
                            'Orders Statistics',
                            style: kInter500(context, fontSize: 16.sp),
                          ),
                          SizedBox(height: 8.h),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.all(20.w),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 105.h,
                                crossAxisCount: 2,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 12.h,
                              ),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () { },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 45.w,
                                        height: 45.w,
                                        child: Center(
                                          child: Image.asset(
                                            "assets/images/order_count.png",
                                            width: 45.w,
                                            height: 45.w,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 8.h),
                                          SizedBox(
                                            width: 90.w,
                                            child: Text(
                                              "234.1k",
                                              style: kInter800(context, fontSize: 24.sp),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          SizedBox(
                                            width: 90.w,
                                            child: Text(
                                              "Total Delivery Charge",
                                              style: kInter500(context, color: kFontColor, fontSize: 16.sp, height: 1.h),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    /// Status Statistics
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      padding: EdgeInsets.fromLTRB(22.w, 6.h, 40.w, 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
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
                          Container(
                            width: 45.w,
                            height: 45.w,
                            padding: EdgeInsets.only(top: 10.h),
                            child: Center(
                              child: Image.asset(
                                "assets/images/status_statistics.png",
                                width: 45.w,
                                height: 45.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 24.w),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status Statistics',
                                  style: kInter500(context, fontSize: 16.sp),
                                ),
                                SizedBox(height: 2.h),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return BlocProvider.value(
                                              value: BlocProvider.of<DashboardBloc>(context),
                                              child: const StatusStatisticsScreen(),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "show details",
                                      style: kInter500(context, color: kColorLightBlue.withOpacity(0.6), fontSize: 16.sp, height: 1.h),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 56.h),
                    Text(
                      'Powered by curfox.lk',
                      style: kInter700(context, color: kFontColor.withOpacity(0.6), fontSize: 11.sp),
                    ),
                    SizedBox(height: 72.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
