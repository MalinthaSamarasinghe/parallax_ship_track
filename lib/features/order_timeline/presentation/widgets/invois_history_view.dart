// import 'dart:async';
// import '../../../utils/font.dart';
// import '../../../utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:timelines/timelines.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../dashboard/presentation/bloc/dashboard_bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:firebase_database/firebase_database.dart' as firebase_database;
//
// class OrderTimelineView extends StatefulWidget {
//   const OrderTimelineView({super.key});
//
//   @override
//   State<OrderTimelineView> createState() => _OrderTimelineViewState();
// }
//
// class _OrderTimelineViewState extends State<OrderTimelineView> {
//   late final StreamSubscription<firebase_database.DatabaseEvent> dataSubscription;
//   String userUid = 'unknown_uid';
//
//   @override
//   void initState() {
//     firebase_auth.FirebaseAuth.instance.currentUser?.reload();
//     userUid = firebase_auth.FirebaseAuth.instance.currentUser?.uid ?? 'unknown_uid';
//     dataSubscription = getData(userUid).listen((data) {
//       context.read<DashboardBloc>().add(DashboardDataChanged(data));
//     }, onError: (error) {
//       debugPrint("Error in data stream: $error");
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     dataSubscription.cancel();
//     super.dispose();
//   }
//
//   Stream<firebase_database.DatabaseEvent> getData(String uid) {
//     return firebase_database.FirebaseDatabase.instance.ref('result/$uid').onValue.map((firebaseData) {
//       return firebaseData;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: double.infinity,
//         height: double.infinity,
//         clipBehavior: Clip.antiAlias,
//         margin: EdgeInsets.fromLTRB(12.w, 60.h, 12.w, 50.h),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(16.r)),
//           border: Border.all(color: kDividerColor, width: 0.5.w),
//           color: kColorWhite,
//         ),
//         child: SingleChildScrollView(
//           physics: const ClampingScrollPhysics(),
//           child: BlocBuilder<DashboardBloc, DashboardState>(
//             buildWhen: (prev, current) {
//               if (prev.status == DashboardStatus.initial && current.status == DashboardStatus.loading) {
//                 return false;
//               } else {
//                 return true;
//               }
//             },
//             builder: (context, state) {
//               return Column(
//                 children: [
//                   MediaQuery.removePadding(
//                     context: context,
//                     removeTop: true,
//                     removeBottom: true,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: 3,
//                       itemBuilder: (context, index) {
//                         return TimelineTile(
//                           contents: Container(
//                             padding: EdgeInsets.only(left: 12.5.w, top: 5.h),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text('gfgdhfhgfgfhghf'),
//                                   ],
//                                 ),
//                                 Container(
//                                   width: 313.w,
//                                   margin: EdgeInsets.only(top: 16.h, bottom: 19.5.h),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.all(Radius.circular(20.r)),
//                                     color: const Color(0xffffffff),
//                                   ),
//                                   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//                                   child: Text(
//                                     'state.timelineEntity![index].message',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           node: TimelineNode(
//                             position: 0,
//                             indicatorPosition: 0,
//                             indicator: DotIndicator(
//                               color: kColorLightBlue,
//                               size: 30.r,
//                               border: Border.all(
//                                 width: 6.5.w,
//                                 color: Color(0xfff9ebac),
//                               ),
//                             ),
//                             /// if last index then remove end connector
//                             endConnector: SolidLineConnector(color: Colors.red),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
