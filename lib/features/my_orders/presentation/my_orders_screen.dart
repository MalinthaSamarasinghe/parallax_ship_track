import 'dart:async';
import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/screen_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../all_orders/presentation/all_orders_screen.dart';
import '../../dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../order_timeline/presentation/order_timeline_view.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_database;

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
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
          title: 'My Orders',
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
                  children: [
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 144.h,
                          crossAxisCount: 2,
                          crossAxisSpacing: 26.w,
                          mainAxisSpacing: 24.h,
                        ),
                        itemCount: 18,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if(index.isEven){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return BlocProvider.value(
                                        value: BlocProvider.of<DashboardBloc>(context),
                                        child: const AllOrdersScreen(),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                _showOrderTimeLineView();
                              }
                            },
                            child: Container(
                              width: 144.w,
                              height: 144.w,
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
                              child: Column(
                                children: [
                                  SizedBox(height: 15.h),
                                  Center(
                                    child: SizedBox(
                                      width: 54.w,
                                      height: 54.w,
                                      child: Image.asset(
                                        "assets/images/add_button.png",
                                        width: 54.w,
                                        height: 54.w,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  SizedBox(
                                    width: 140.w,
                                    child: Text(
                                      "3.1k",
                                      style: kInter800(context, fontSize: 18.sp),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 140.w,
                                    child: Text(
                                      "All Orders",
                                      style: kInter500(context, fontSize: 16.sp),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
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

  void _showOrderTimeLineView() {
    showDialog<String>(
      context: context,
      barrierColor: kDialogBgColor.withOpacity(0.3),
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<DashboardBloc>(context),
          child: const OrderTimelineView(),
        );
      },
    );
  }
}
