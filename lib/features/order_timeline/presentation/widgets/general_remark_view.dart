import 'dart:async';
import '../../../../utils/font.dart';
import '../../../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_database/firebase_database.dart' as firebase_database;

class GeneralRemarkView extends StatefulWidget {
  const GeneralRemarkView({super.key});

  @override
  State<GeneralRemarkView> createState() => _GeneralRemarkViewState();
}

class _GeneralRemarkViewState extends State<GeneralRemarkView> {
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
    return SingleChildScrollView(
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
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.fromLTRB(12.w, 58.h, 12.w, 0),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return TimelineTile(
                  contents: Container(
                    padding: EdgeInsets.only(left: 14.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Remarked By
                        Row(
                          children: [
                            SizedBox(
                              width: 98.w,
                              child: Text(
                                "Remarked By",
                                style: kInter400(context, fontSize: 12.sp),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: ":    ",
                                    style: kInter400(context, fontSize: 12.sp),
                                  ),
                                  TextSpan(
                                    text: "Mr.John Deo",
                                    style: kInter400(context, fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        /// Remarked
                        Row(
                          children: [
                            SizedBox(
                              width: 98.w,
                              child: Text(
                                "Remarked",
                                style: kInter400(context, fontSize: 12.sp),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: ":    ",
                                    style: kInter400(context, fontSize: 12.sp),
                                  ),
                                  TextSpan(
                                    text: "Stock sold out",
                                    style: kInter400(context, fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        /// Tags
                        Row(
                          children: [
                            SizedBox(
                              width: 98.w,
                              child: Text(
                                "Tags",
                                style: kInter400(context, fontSize: 12.sp),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              ":    ",
                              style: kInter400(context, fontSize: 12.sp),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 7.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: kColorRed.withOpacity(0.2),
                              ),
                              child: Text(
                                "No Specified Tags",
                                style: kInter500(context, fontSize: 12.sp, color: kColorWhite),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        /// Remark Date
                        Row(
                          children: [
                            SizedBox(
                              width: 98.w,
                              child: Text(
                                "Remark Date",
                                style: kInter400(context, fontSize: 12.sp),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: ":    ",
                                    style: kInter400(context, fontSize: 12.sp),
                                  ),
                                  TextSpan(
                                    text: "04/06/2023 20:28",
                                    style: kInter400(context, fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        /// Read By
                        Row(
                          children: [
                            SizedBox(
                              width: 98.w,
                              child: Text(
                                "Read By",
                                style: kInter400(context, fontSize: 12.sp),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: ":    ",
                                    style: kInter400(context, fontSize: 12.sp),
                                  ),
                                  TextSpan(
                                    text: "1",
                                    style: kInter400(context, fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
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
          );
        },
      ),
    );
  }
}
