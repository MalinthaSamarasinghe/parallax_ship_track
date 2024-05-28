import 'dart:async';
import '../../../../utils/font.dart';
import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_database/firebase_database.dart' as firebase_database;

class InvoiceHistoryView extends StatefulWidget {
  const InvoiceHistoryView({super.key});

  @override
  State<InvoiceHistoryView> createState() => _InvoiceHistoryViewState();
}

class _InvoiceHistoryViewState extends State<InvoiceHistoryView> {
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
                        /// Approved
                        Text(
                          "Approved",
                          style: kInter400(context, fontSize: 12.sp),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 3.h),
                        /// LKR 804
                        Text(
                          "LKR 804",
                          style: kInter400(context, fontSize: 12.sp),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 31.w,
                              height: 31.w,
                              child: Image.asset(
                                "assets/images/invoice_icon.png",
                                width: 31.w,
                                height: 31.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Demo Admin
                                Text(
                                  "Demo Admin",
                                  style: kInter400(context, fontSize: 12.sp),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 4.h),
                                /// Super Admin
                                Text(
                                  "Super Admin",
                                  style: kInter400(context, fontSize: 12.sp),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 38.h),
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
