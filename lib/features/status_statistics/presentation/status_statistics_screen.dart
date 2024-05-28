import 'dart:async';
import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/screen_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_database/firebase_database.dart' as firebase_database;

class StatusStatisticsScreen extends StatefulWidget {
  const StatusStatisticsScreen({super.key});

  @override
  State<StatusStatisticsScreen> createState() => _StatusStatisticsScreenState();
}

class _StatusStatisticsScreenState extends State<StatusStatisticsScreen> {
  late final StreamSubscription<firebase_database.DatabaseEvent> dataSubscription;
  final List<Item> _data = List<Item>.generate(
    10, (int index) => Item(
      headerValue: 'Item $index',
      expandedValue: 'Details for item $index',
    ),
  );
  String userUid = 'unknown_uid';
  bool isListExpanded = false;

  @override
  void initState() {
    firebase_auth.FirebaseAuth.instance.currentUser?.reload();
    userUid = firebase_auth.FirebaseAuth.instance.currentUser?.uid ?? 'unknown_uid';
    dataSubscription = getData(userUid).listen((data) {
      context.read<DashboardBloc>().add(DashboardOrderStatisticsChanged(data));
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
                          Text(
                            'Status Statistics',
                            style: kInter500(context, fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.ease,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView.builder(
                          itemCount: _data.length > 6
                              ? isListExpanded ? _data.length : 6
                              : _data.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.all(12.w),
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
                              child: AnimatedSize(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.ease,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Center(
                                          child: Image.asset(
                                            "assets/images/add_button.png",
                                            width: 40.w,
                                            height: 40.w,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        SizedBox(width: 15.w),
                                        Expanded(
                                          child: Text(
                                            _data[index].headerValue,
                                            style: kMontserrat500(context, fontSize: 14.sp),
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _data[index].isExpanded = !_data[index].isExpanded;
                                            });
                                          },
                                          child: !_data[index].isExpanded
                                              ? Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            size: 24.r,
                                            color: kFontColor,
                                          )
                                              : const SizedBox(),
                                        ),
                                        SizedBox(width: 20.w),
                                      ],
                                    ),
                                    _data[index].isExpanded
                                        ? Column(
                                            children: [
                                              MediaQuery.removePadding(
                                                context: context,
                                                removeTop: true,
                                                removeBottom: true,
                                                child: GridView.builder(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.fromLTRB(2.w, 5.h, 2.w, 5.h),
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisExtent: 100.h,
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 20.w,
                                                    mainAxisSpacing: 20.h,
                                                  ),
                                                  itemCount: 2,
                                                  itemBuilder: (context, index) {
                                                    return GestureDetector(
                                                      onTap: () { },
                                                      child: Container(
                                                        width: 148.w,
                                                        height: 100.h,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(16.r),
                                                          color: kStaticColor,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(height: 15.h),
                                                            SizedBox(
                                                              width: 140.w,
                                                              child: Text(
                                                                "Delivery Charge",
                                                                style: kMontserrat500(context, fontSize: 14.sp),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                            SizedBox(height: 10.h),
                                                            Padding(
                                                              padding: EdgeInsets.only(left: 18.w, right: 10.w),
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Center(
                                                                    child: SizedBox(
                                                                      width: 40.w,
                                                                      height: 40.w,
                                                                      child: Image.asset(
                                                                        "assets/images/add_button.png",
                                                                        width: 40.w,
                                                                        height: 40.w,
                                                                        fit: BoxFit.fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      "50371.50",
                                                                      style: kMontserrat600(context, color: kFontColor, fontSize: 14.sp),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 5.h, left: 40.w, right: 20.w),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: RichText(
                                                        textAlign: TextAlign.center,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "Ratio   :    ",
                                                              style: kMontserrat600(context, color: kFontColor, fontSize: 14.sp),
                                                            ),
                                                            TextSpan(
                                                              text: "67%",
                                                              style: kMontserrat600(context, color: kFontColor, fontSize: 14.sp),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _data[index].isExpanded = !_data[index].isExpanded;
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.keyboard_arrow_up_outlined,
                                                        size: 24.r,
                                                        color: kFontColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isListExpanded = !isListExpanded;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            isListExpanded ? 'see less' : 'see more',
                            style: kInter500(context, color: kColorLightBlue.withOpacity(0.6), fontSize: 16.sp, height: 0.8.h),
                          ),
                          Icon(
                            isListExpanded ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined,
                            size: 24.r,
                            color: kColorLightBlue.withOpacity(0.6),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
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

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
