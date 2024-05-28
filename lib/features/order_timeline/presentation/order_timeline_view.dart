import 'dart:async';
import '../../../utils/font.dart';
import '../../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'widgets/order_history_view.dart';
import 'widgets/general_remark_view.dart';
import 'widgets/invoice_history_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_database/firebase_database.dart' as firebase_database;

class OrderTimelineView extends StatefulWidget {
  const OrderTimelineView({super.key});

  @override
  State<OrderTimelineView> createState() => _OrderTimelineViewState();
}

class _OrderTimelineViewState extends State<OrderTimelineView> {
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
      child: DefaultTabController(
        length: 3,
        child: Column(
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
            SizedBox(
              height: 40.h,
              child: TabBar(
                physics: const ClampingScrollPhysics(),
                labelStyle: kInter400(context, fontSize: 12.sp),
                unselectedLabelStyle: kInter400(context, fontSize: 12.sp),
                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 10.h),
                dividerColor: Colors.transparent,
                dividerHeight: 0,
                automaticIndicatorColorAdjustment: false,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 6.w),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: kIndicatorColor,
                indicatorWeight: 3.h,
                tabAlignment: TabAlignment.fill,
                labelPadding: EdgeInsets.zero,
                tabs: const [
                  Tab(text: 'Order History'),
                  Tab(text: 'Invoice History'),
                  Tab(text: 'General Remark'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                physics: ClampingScrollPhysics(),
                children: [
                  OrderHistoryView(),
                  InvoiceHistoryView(),
                  GeneralRemarkView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
