import 'dart:async';
import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_database/firebase_database.dart' as firebase_database;

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({super.key});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  late final StreamSubscription<firebase_database.DatabaseEvent> dataSubscription;
  String userUid = 'unknown_uid';

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
    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.fromLTRB(12.w, 60.h, 12.w, 50.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        border: Border.all(color: kDividerColor, width: 0.5.w),
        color: kColorWhite,
      ),
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
                SizedBox(height: 6.h),
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.close_outlined),
                      iconSize: 14.r,
                      onPressed: (){},
                      color: kColorBlack,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "View Order Details",
                  style: kInter500(context, color: kFontColor, fontSize: 15.sp),
                  textAlign: TextAlign.left,
                ),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(12.w, 20.h, 12.w, 0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return TimelineTile(
                        contents: Container(
                          padding: EdgeInsets.only(left: 14.w),
                          child: index == 0
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 68.w,
                                      height: 68.w,
                                      child: Image.asset(
                                        "assets/images/invoice_test_user.png",
                                        width: 68.w,
                                        height: 68.w,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.r),
                                            color: kColorRed.withOpacity(0.2),
                                          ),
                                          child: Text(
                                            'CF0003034',
                                            style: kInter500(context, color: kColorBlack, fontSize: 14.sp),
                                          ),
                                        ),
                                        SizedBox(height: 22.h),
                                        /// COD: Rs.250
                                        Text(
                                          "COD: Rs.250",
                                          style: kInter400(context, fontSize: 12.sp),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 3.h),
                                        /// Weight: 1kg
                                        Text(
                                          "Weight: 1kg",
                                          style: kInter400(context, fontSize: 12.sp),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 3.h),
                                        /// Created on: 02/06/2023 14:49
                                        Text(
                                          "Created on: 02/06/2023 14:49",
                                          style: kInter400(context, fontSize: 12.sp),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 40.h),
                                      ],
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Merchant Details
                                    Text(
                                      "Merchant Details",
                                      style: kInter400(context, fontSize: 14.sp),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(height: 18.h),
                                    /// Iphone Store
                                    Text(
                                      "Iphone Store",
                                      style: kInter400(context, fontSize: 12.sp),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(height: 3.h),
                                    /// MC-0002
                                    Text(
                                      "MC-0002",
                                      style: kInter400(context, fontSize: 12.sp),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(height: 3.h),
                                    /// Pickup Address: 280, Duplication Road, Colombo
                                    Text(
                                      "Pickup Address: 280, Duplication Road, Colombo",
                                      style: kInter400(context, fontSize: 12.sp),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(height: 3.h),
                                    /// Origin City: Nugegoda
                                    Text(
                                      "Origin City: Nugegoda",
                                      style: kInter400(context, fontSize: 12.sp),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(height: 3.h),
                                    /// Origin Warehouse: Trans Express
                                    Text(
                                      "Origin Warehouse: Trans Express",
                                      style: kInter400(context, fontSize: 12.sp),
                                      textAlign: TextAlign.left,
                                    ),
                                    /// Destination Warehouse: Trans Express
                                    index == 2
                                      ? Padding(
                                        padding: EdgeInsets.only(top: 3.h),
                                          child: Text(
                                            "Destination Warehouse: Trans Express",
                                            style: kInter400(context, fontSize: 12.sp),
                                            textAlign: TextAlign.left,
                                          ),
                                        )
                                      : SizedBox(height: 3.h),
                                    SizedBox(height: 37.h),
                                  ],
                                ),
                        ),
                        node: TimelineNode(
                          position: 0,
                          indicatorPosition: 0,
                          indicator: DotIndicator(color: kIndicatorColor, size: 16.r),
                          /// TODO: if last index then remove end connector
                          endConnector: const SolidLineConnector(color: kIndicatorColor),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
