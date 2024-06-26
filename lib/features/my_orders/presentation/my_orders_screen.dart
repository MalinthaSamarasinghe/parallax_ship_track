import 'dart:async';
import '../../../injector.dart';
import '../../../utils/font.dart';
import 'bloc/my_orders_bloc.dart';
import '../../../utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../core/presentation/screen_app_bar.dart';
import '../../../core/presentation/shimmer_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../all_orders/presentation/all_orders_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../all_orders/presentation/bloc/all_orders_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_database/firebase_database.dart' as firebase_database;

class MyOrdersScreenWrapper extends StatelessWidget {
  const MyOrdersScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllOrdersBloc>(
          create: (context) => sl<AllOrdersBloc>(),
        ),
      ],
      child: const MyOrdersScreen(),
    );
  }
}

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  late final StreamSubscription<firebase_database.DatabaseEvent> myOrderDataSubscription;
  String userUid = 'unknown_uid';

  @override
  void initState() {
    firebase_auth.FirebaseAuth.instance.currentUser?.reload();
    userUid = firebase_auth.FirebaseAuth.instance.currentUser?.uid ?? 'unknown_uid';
    myOrderDataSubscription = getMyOrdersData(userUid).listen((data) {
      context.read<MyOrdersBloc>().add(MyOrdersChanged(data));
    }, onError: (error) {
      debugPrint("Error in data stream: $error");
    });
    super.initState();
  }

  @override
  void dispose() {
    myOrderDataSubscription.cancel();
    super.dispose();
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
          title: 'My Orders',
          onTrailingPress: () { },
          onLeadingPress: () {
            Navigator.pop(context);
          },
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: kDashboardColor,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<MyOrdersBloc, MyOrdersState>(
              buildWhen: (prev, current) {
                if (prev.status == MyOrdersStatus.initial && current.status == MyOrdersStatus.loading) {
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
                        itemCount: (state.myOrdersData ?? []).length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if((state.myOrdersData ?? []).isNotEmpty && state.myOrdersData![index].name == 'All Orders'){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return BlocProvider.value(
                                        value: BlocProvider.of<AllOrdersBloc>(context),
                                        child: const AllOrdersScreen(),
                                      );
                                    },
                                  ),
                                );
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
                                      child: CachedNetworkImage(
                                        imageUrl: (state.myOrdersData ?? []).isNotEmpty
                                            ? state.myOrdersData![index].imagePath
                                            : '',
                                        placeholder: (context, url) => Container(
                                          width: 54.w,
                                          height: 54.w,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(12.r)),
                                          ),
                                          child: shimmerLoader(),
                                        ),
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
                                  SizedBox(height: 5.h),
                                  SizedBox(
                                    width: 130.w,
                                    child: AutoSizeText(
                                      (state.myOrdersData ?? []).isNotEmpty ? state.myOrdersData![index].value : '',
                                      style: kInter800(context, fontSize: 18.sp),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 18,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 135.w,
                                    child: AutoSizeText(
                                      (state.myOrdersData ?? []).isNotEmpty ? state.myOrdersData![index].name : '',
                                      style: kInter500(context, color: kFontColor, fontSize: 16.sp),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 16,
                                      maxLines: 1,
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

  /// TODO: Implement this method
  // void _showOrderTabView() {
  //   showDialog<String>(
  //     context: context,
  //     barrierColor: kDialogBgColor.withOpacity(0.3),
  //     builder: (_) {
  //       return BlocProvider.value(
  //         value: BlocProvider.of<DashboardBloc>(context),
  //         child: const OrderDetailsTabView(),
  //       );
  //     },
  //   );
  // }
}
