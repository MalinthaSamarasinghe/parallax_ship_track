import 'dart:async';
import '../../../injector.dart';
import '../../../utils/font.dart';
import 'bloc/dashboard_bloc.dart';
import '../../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/error_box.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../core/presentation/screen_app_bar.dart';
import '../../../core/presentation/shimmer_builder.dart';
import '../../my_orders/presentation/my_orders_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../my_orders/presentation/bloc/my_orders_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        BlocProvider<MyOrdersBloc>(
          create: (context) => sl<MyOrdersBloc>(),
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
  late final StreamSubscription<firebase_database.DatabaseEvent> orderStatisticsDataSubscription;
  late final StreamSubscription<firebase_database.DatabaseEvent> financeStatisticsDataSubscription;
  late final StreamSubscription<firebase_database.DatabaseEvent> myOrderDataSubscription;
  String userUid = 'unknown_uid';

  @override
  void initState() {
    firebase_auth.FirebaseAuth.instance.currentUser?.reload();
    userUid = firebase_auth.FirebaseAuth.instance.currentUser?.uid ?? 'unknown_uid';
    orderStatisticsDataSubscription = getOrderStatisticsData().listen((data) {
      context.read<DashboardBloc>().add(DashboardOrderStatisticsChanged(data));
    }, onError: (error) {
      debugPrint("Error in data stream: $error");
    });
    financeStatisticsDataSubscription = getFinanceStatisticsData().listen((data) {
      context.read<DashboardBloc>().add(DashboardFinanceStatisticsChanged(data));
    }, onError: (error) {
      debugPrint("Error in data stream: $error");
    });
    myOrderDataSubscription = getMyOrdersData(userUid).listen((data) {
      context.read<MyOrdersBloc>().add(MyOrdersChanged(data));
    }, onError: (error) {
      debugPrint("Error in data stream: $error");
    });
    super.initState();
  }

  @override
  void dispose() {
    orderStatisticsDataSubscription.cancel();
    financeStatisticsDataSubscription.cancel();
    myOrderDataSubscription.cancel();
    super.dispose();
  }

  Stream<firebase_database.DatabaseEvent> getOrderStatisticsData() {
    return firebase_database.FirebaseDatabase.instance.ref('Order_Statistics').onValue.map((firebaseData) {
      return firebaseData;
    });
  }

  Stream<firebase_database.DatabaseEvent> getFinanceStatisticsData() {
    return firebase_database.FirebaseDatabase.instance.ref('Finance_Statistics').onValue.map((firebaseData) {
      return firebaseData;
    });
  }

  Stream<firebase_database.DatabaseEvent> getMyOrdersData(String uid) {
    return firebase_database.FirebaseDatabase.instance.ref('Users/$uid').onValue.map((firebaseData) {
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
          onLeadingPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return BlocProvider.value(
                    value: BlocProvider.of<MyOrdersBloc>(context),
                    child: const MyOrdersScreen(),
                  );
                },
              ),
            );
          },
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: kDashboardColor,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                      child: state.status == DashboardStatus.initial
                        ? ordersStatisticsShimmerLoader(2)
                        : state.status == DashboardStatus.failure
                          ? statisticsErrorWidget('Orders Statistics', state.errorMessage ?? 'Data Fetch Failed!')
                          : (state.dashboardOrderStatisticsData ?? []).isEmpty
                            ? statisticsErrorWidget('Orders Statistics', 'No Data Available!')
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  /// Orders Statistics
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    child: AutoSizeText(
                                      (state.dashboardOrderStatisticsData ?? []).isNotEmpty ? state.dashboardOrderStatisticsData?.first.mainCategory ?? '' : '',
                                      style: kInter600(context, fontSize: 16.sp),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 16,
                                      maxLines: 1,
                                    ),
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
                                        mainAxisExtent: 100.h,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 10.h,
                                      ),
                                      itemCount: (state.dashboardOrderStatisticsData ?? []).length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () { },
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              /// Orders Statistics Icon
                                              SizedBox(
                                                width: 45.w,
                                                height: 45.w,
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: (state.dashboardOrderStatisticsData ?? []).isNotEmpty
                                                        ? state.dashboardOrderStatisticsData![index].imagePath
                                                        : '',
                                                    placeholder: (context, url) => shimmerLoader(),
                                                    errorWidget: (context, url, error) => SvgPicture.asset(
                                                      'assets/svg/error_warning.svg',
                                                      colorFilter: const ColorFilter.mode(kFontColor, BlendMode.srcIn),
                                                      fit: BoxFit.contain,
                                                    ),
                                                    useOldImageOnUrlChange: true,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 8.h),
                                                  /// 3.1.k
                                                  SizedBox(
                                                    width: 90.w,
                                                    child: AutoSizeText(
                                                      (state.dashboardOrderStatisticsData ?? []).isNotEmpty ? state.dashboardOrderStatisticsData![index].value : '',
                                                      style: kInter800(context, fontSize: 24.sp),
                                                      textAlign: TextAlign.left,
                                                      overflow: TextOverflow.ellipsis,
                                                      minFontSize: 24,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  /// Orders Count
                                                  SizedBox(
                                                    width: 90.w,
                                                    child: AutoSizeText(
                                                      (state.dashboardOrderStatisticsData ?? []).isNotEmpty ? state.dashboardOrderStatisticsData![index].name : '',
                                                      style: kInter500(context, color: kFontColor, fontSize: 16.sp, height: 1.h),
                                                      textAlign: TextAlign.left,
                                                      overflow: TextOverflow.ellipsis,
                                                      minFontSize: 16,
                                                      maxLines: 3,
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
                      child: state.status == DashboardStatus.initial
                        ? ordersStatisticsShimmerLoader(4)
                        : state.status == DashboardStatus.failure
                          ? statisticsErrorWidget('Finance Statistics', state.errorMessage ?? 'Data Fetch Failed!')
                          : (state.dashboardFinanceStatisticsData ?? []).isEmpty
                            ? statisticsErrorWidget('Finance Statistics', 'No Data Available!')
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  /// Finance Statistics
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    child: AutoSizeText(
                                      (state.dashboardFinanceStatisticsData ?? []).isNotEmpty ? state.dashboardFinanceStatisticsData?.first.mainCategory ?? '' : '',
                                      style: kInter600(context, fontSize: 16.sp),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 16,
                                      maxLines: 1,
                                    ),
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
                                        mainAxisExtent: 100.h,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 10.h,
                                      ),
                                      itemCount: 4,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () { },
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              /// Finance Statistics Icon
                                              SizedBox(
                                                width: 45.w,
                                                height: 45.w,
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: (state.dashboardFinanceStatisticsData ?? []).isNotEmpty
                                                        ? state.dashboardFinanceStatisticsData![index].imagePath
                                                        : '',
                                                    placeholder: (context, url) => shimmerLoader(),
                                                    errorWidget: (context, url, error) => SvgPicture.asset(
                                                      'assets/svg/error_warning.svg',
                                                      colorFilter: const ColorFilter.mode(kFontColor, BlendMode.srcIn),
                                                      fit: BoxFit.contain,
                                                    ),
                                                    useOldImageOnUrlChange: true,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 8.h),
                                                  /// Invoice value
                                                  SizedBox(
                                                    width: 90.w,
                                                    child: AutoSizeText(
                                                      (state.dashboardFinanceStatisticsData ?? []).isNotEmpty ? state.dashboardFinanceStatisticsData![index].value : '',
                                                      style: kInter800(context, fontSize: 24.sp),
                                                      textAlign: TextAlign.left,
                                                      overflow: TextOverflow.ellipsis,
                                                      minFontSize: 24,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  /// Pending Invoice
                                                  SizedBox(
                                                    width: 90.w,
                                                    child: AutoSizeText(
                                                      (state.dashboardFinanceStatisticsData ?? []).isNotEmpty ? state.dashboardFinanceStatisticsData![index].name : '',
                                                      style: kInter500(context, color: kFontColor, fontSize: 16.sp, height: 1.h),
                                                      textAlign: TextAlign.left,
                                                      overflow: TextOverflow.ellipsis,
                                                      minFontSize: 16,
                                                      maxLines: 3,
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
                      padding: EdgeInsets.fromLTRB(22.w, 6.h, 42.w, 13.h),
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
                          /// Status Statistics Icon
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
                                /// Status Statistics
                                Text(
                                  'Status Statistics',
                                  style: kInter600(context, fontSize: 16.sp),
                                ),
                                SizedBox(height: 2.h),
                                /// show details
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
                    /// Powered by curfox.lk
                    Text(
                      'Powered by curfox.lk',
                      style: kInter700(context, color: kFontColor.withOpacity(0.7), fontSize: 11.sp),
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

  Widget ordersStatisticsShimmerLoader(int itemCount) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 14.h),
        /// Orders Statistics Shimmer
        Container(
          height: 13.h,
          width: 124.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: shimmerLoader(),
        ),
        SizedBox(height: 14.h),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(20.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 100.h,
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 10.h,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Orders Statistics Icon Shimmer
                  Container(
                    height: 45.h,
                    width: 45.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    ),
                    child: shimmerLoader(),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),
                      /// 3.1.k Shimmer
                      Container(
                        height: 20.h,
                        width: 45.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        ),
                        child: shimmerLoader(),
                      ),
                      SizedBox(height: 14.h),
                      /// Orders Count Line 1 Shimmer
                      Container(
                        height: 12.h,
                        width: 75.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: shimmerLoader(),
                      ),
                      SizedBox(height: 8.h),
                      /// Orders Count Line 2 Shimmer
                      Container(
                        height: 12.h,
                        width: 60.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        ),
                        child: shimmerLoader(),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget statisticsErrorWidget(String title, String errorMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        /// Orders Statistics
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: AutoSizeText(
            title,
            style: kInter600(context, fontSize: 16.sp),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            minFontSize: 16,
            maxLines: 1,
          ),
        ),
        ErrorBox(
          title: '',
          outerPadding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 12.h),
          description: errorMessage,
        ),
      ],
    );
  }
}
