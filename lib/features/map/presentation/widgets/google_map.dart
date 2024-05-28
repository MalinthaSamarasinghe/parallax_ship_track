// import 'dart:io';
// import 'dart:async';
// import '../../../../utils/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import '../../../../utils/api_endpoints.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import '../../../../core/other/price_convertor.dart';
// import '../../../../core/enums/bloc_state_status.dart';
// import '../../domain/usecase/get_google_map_data.dart';
// import '../../../../core/other/other_apps_launcher.dart';
// import '../bloc/google_map_data/google_map_data_bloc.dart';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../../../core/presentation/reusable/snack_bar.dart';
// import '../../../my_visits/presentation/bloc/my_visits_bloc.dart';
// import '../../../../core/presentation/reusable/button_filled.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import '../../../../core/presentation/reusable/triangle_painter.dart';
// import '../../../../core/presentation/reusable/vertical_divider.dart';
//
// class GoogleMapWidget extends StatefulWidget {
//   final Position userCurrentLocationData;
//
//   const GoogleMapWidget({
//     super.key,
//     required this.userCurrentLocationData,
//   });
//
//   @override
//   State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
// }
//
// class _GoogleMapWidgetState extends State<GoogleMapWidget> {
//   final CustomInfoWindowController _customInfoWindowUserController = CustomInfoWindowController();
//   final CustomInfoWindowController _customInfoWindowSellerController = CustomInfoWindowController();
//   final Completer<GoogleMapController?> _googleMapController = Completer();
//   late GoogleMapController _googleMapViewController;
//   StreamSubscription<Position>? locationSubscription;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   late LocationAccuracyStatus accuracyStatus;
//   late LocationSettings locationSettings;
//   late LatLng userCurrentLatLng;
//   bool isNormalMapType = true;
//   bool isZoomDirection = false;
//   bool isDetailsOn = false;
//   final Set<Polyline> _polyline = {};
//   final Set<Marker> _markers = {};
//   late Marker userMarker;
//   Polyline directionPolyline = const Polyline(polylineId: PolylineId('_newPolyline'));
//   String vehicleTitle = 'N/A';
//   String vehicleMake = 'N/A';
//   String vehicleModel = 'N/A';
//   String vehicleSellerName = 'N/A';
//   String vehicleSellerAddress = 'N/A';
//   bool vehicleIsPriceHide = false;
//   int vehiclePrice = 0;
//   double vehicleLat = 0.0;
//   double vehicleLng = 0.0;
//
//   @override
//   void initState() {
//     setState(() {
//       userCurrentLatLng = LatLng(widget.userCurrentLocationData.latitude, widget.userCurrentLocationData.longitude);
//     });
//     _setInitialMarkers(userCurrentLatLng, widget.sellersLocationList);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     locationSubscription?.cancel();
//     _googleMapViewController.dispose();
//     _customInfoWindowUserController.dispose();
//     _customInfoWindowSellerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<GoogleMapDataBloc, GoogleMapDataState>(
//       buildWhen: (prev, current) {
//         if (prev.status == Status.initial && current.status == Status.loadInProgress) {
//           return false;
//         } else {
//           return true;
//         }
//       },
//       listener: (context, state) {
//         if (state.status == Status.loadFailure) {
//           EasyLoading.dismiss();
//           Future.delayed(const Duration(milliseconds: 100), () {
//             SnackBarReusable().showSnackBar(context, "${state.failureMessage}", 4, false, _scaffoldKey);
//           });
//         }
//         if (state.status == Status.loadSuccess) {
//           FocusManager.instance.primaryFocus?.unfocus();
//           List<PointLatLng> polylinePoints  = PolylinePoints().decodePolyline(state.mapData!.routes!.first.overviewPolyline.points);
//           directionPolyline = Polyline(
//             polylineId: const PolylineId('_newPolyline'),
//             color: AppStyle.colors.blueColor,
//             width: 6,
//             points: polylinePoints.map((e) => LatLng(e.latitude, e.longitude)).toList(),
//           );
//           setState(() {
//             isZoomDirection = true;
//             isDetailsOn = true;
//             _polyline.add(directionPolyline);
//           });
//           EasyLoading.dismiss();
//           _googleMapViewController.animateCamera(
//             CameraUpdate.newLatLngBounds(
//               LatLngBounds(
//                 southwest: LatLng(state.mapData!.routes!.first.bounds.southwest.lat, state.mapData!.routes!.first.bounds.southwest.lng),
//                 northeast: LatLng(state.mapData!.routes!.first.bounds.northeast.lat, state.mapData!.routes!.first.bounds.northeast.lng),
//               ),
//               10,
//             ),
//           );
//         }
//         if (state.status == Status.loadInProgress) {
//           FocusManager.instance.primaryFocus?.unfocus();
//           EasyLoading.show(status: 'Please Wait', dismissOnTap: false);
//           setState(() {
//             _polyline.remove(directionPolyline);
//           });
//         }
//       },
//       builder: (context, state) {
//         return Column(
//           children: [
//             Expanded(
//               child: Stack(
//                 children: [
//                   GoogleMap(
//                     onMapCreated: (controller) {
//                       _googleMapViewController = controller;
//                       _googleMapController.complete(controller);
//                       _customInfoWindowUserController.googleMapController = controller;
//                       _customInfoWindowSellerController.googleMapController = controller;
//                     },
//                     initialCameraPosition: CameraPosition(
//                       target: LatLng(
//                         widget.userCurrentLocationData.latitude,
//                         widget.userCurrentLocationData.longitude,
//                       ),
//                       zoom: 10,
//                     ),
//                     onCameraMove: (position) {
//                       _customInfoWindowUserController.onCameraMove!();
//                       _customInfoWindowSellerController.onCameraMove!();
//                     },
//                     onTap: (position) {
//                       _customInfoWindowUserController.hideInfoWindow!();
//                       _customInfoWindowSellerController.hideInfoWindow!();
//                     },
//                     markers: _markers,
//                     polylines: _polyline,
//                     mapType: isNormalMapType ? MapType.normal : MapType.satellite,
//                     compassEnabled: false,
//                     mapToolbarEnabled: false,
//                     myLocationEnabled: false,
//                     myLocationButtonEnabled: false,
//                   ),
//                   /// CustomInfoWindow for User
//                   CustomInfoWindow(
//                     controller: _customInfoWindowUserController,
//                     offset: 36.h,
//                     height: 64.h,
//                     width: 150.w,
//                   ),
//                   /// CustomInfoWindow for Sellers
//                   CustomInfoWindow(
//                     controller: _customInfoWindowSellerController,
//                     offset: 44.h,
//                     height: 70.h,
//                     width: 222.w,
//                   ),
//                   /// Button To Change Map Type
//                   Positioned(
//                     top: 10.w,
//                     right: 10.w,
//                     child: ButtonBar(
//                       buttonPadding: EdgeInsets.zero,
//                       buttonTextTheme: ButtonTextTheme.primary,
//                       alignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         /// Map Type Button
//                         Opacity(
//                           opacity: 0.8,
//                           child: Container(
//                             height: 42.h,
//                             width: 78.w,
//                             decoration: BoxDecoration(
//                               color: AppStyle.colors.googleMapBtnColor,
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(2.r),
//                                 bottomLeft: Radius.circular(2.r),
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppStyle.colors.blackColor.withOpacity(0.2),
//                                   offset: const Offset(0, 2),
//                                   blurRadius: 0.5,
//                                   spreadRadius: 0.5,
//                                 ),
//                               ],
//                             ),
//                             child: TextButton(
//                               onPressed: () {
//                                 setState(() {
//                                   if(isNormalMapType == false){
//                                     isNormalMapType = true;
//                                   }
//                                 });
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 foregroundColor: AppStyle.colors.greyTxt,
//                                 backgroundColor: AppStyle.colors.textFieldColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(2.r),
//                                     bottomLeft: Radius.circular(2.r),
//                                   ),
//                                 ),
//                               ),
//                               child: Text(
//                                 'Map',
//                                 textAlign: TextAlign.center,
//                                 style: AppStyle.textStyle.textStyleLabel.copyWith(
//                                   fontSize: 17.sp,
//                                   color: isNormalMapType
//                                       ? AppStyle.colors.blackColor
//                                       : AppStyle.colors.blackColor.withOpacity(0.6),
//                                   fontWeight: isNormalMapType
//                                       ? FontWeight.w600
//                                       : FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         /// Custom VerticalDivider
//                         Opacity(
//                           opacity: 0.8,
//                           child: SizedBox(
//                             height: 20.h,
//                             width: 0.5.w,
//                             child: VerticalDividerContainer(color: AppStyle.colors.greyTxt),
//                           ),
//                         ),
//                         /// Satellite Type Button
//                         Opacity(
//                           opacity: 0.8,
//                           child: Container(
//                             height: 42.h,
//                             width: 105.w,
//                             decoration: BoxDecoration(
//                               color: AppStyle.colors.googleMapBtnColor,
//                               borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(2.r),
//                                 bottomRight: Radius.circular(2.r),
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppStyle.colors.blackColor.withOpacity(0.2),
//                                   offset: const Offset(0, 2),
//                                   blurRadius: 0.5,
//                                   spreadRadius: 0.5,
//                                 ),
//                               ],
//                             ),
//                             child: TextButton(
//                               onPressed: () {
//                                 setState(() {
//                                   if(isNormalMapType == true){
//                                     isNormalMapType = false;
//                                   }
//                                 });
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 foregroundColor: AppStyle.colors.greyTxt,
//                                 backgroundColor: AppStyle.colors.textFieldColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(2.r),
//                                     bottomRight: Radius.circular(2.r),
//                                   ),
//                                 ),
//                               ),
//                               child: Text(
//                                 'Satellite',
//                                 textAlign: TextAlign.center,
//                                 style: AppStyle.textStyle.textStyleLabel.copyWith(
//                                   fontSize: 17.sp,
//                                   color: !isNormalMapType
//                                       ? AppStyle.colors.blackColor
//                                       : AppStyle.colors.blackColor.withOpacity(0.6),
//                                   fontWeight: !isNormalMapType
//                                       ? FontWeight.w600
//                                       : FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   /// button to zoom
//                   Positioned(
//                     top: 60.h,
//                     right: 10.w,
//                     child: ButtonBar(
//                       buttonPadding: EdgeInsets.zero,
//                       buttonTextTheme: ButtonTextTheme.primary,
//                       alignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         /// zoom Button
//                         Opacity(
//                           opacity: 0.8,
//                           child: Container(
//                             height: 38.w,
//                             width: 38.w,
//                             decoration: BoxDecoration(
//                               color: AppStyle.colors.googleMapBtnColor,
//                               borderRadius: BorderRadius.all(Radius.circular(2.r)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppStyle.colors.blackColor.withOpacity(0.2),
//                                   offset: const Offset(0, 2),
//                                   blurRadius: 0.5,
//                                   spreadRadius: 0.5,
//                                 ),
//                               ],
//                             ),
//                             child: Center(
//                               child: TextButton(
//                                 onPressed: () {
//                                   _googleMapViewController.animateCamera(
//                                     isZoomDirection
//                                         ? CameraUpdate.newCameraPosition(
//                                             CameraPosition(
//                                               target: LatLng(
//                                                 userCurrentLatLng.latitude,
//                                                 userCurrentLatLng.longitude,
//                                               ),
//                                               zoom: 10,
//                                             ),
//                                           )
//                                         : state.mapData != null
//                                             ? CameraUpdate.newLatLngBounds(
//                                                 LatLngBounds(
//                                                   southwest: LatLng(state.mapData!.routes!.first.bounds.southwest.lat, state.mapData!.routes!.first.bounds.southwest.lng),
//                                                   northeast: LatLng(state.mapData!.routes!.first.bounds.northeast.lat, state.mapData!.routes!.first.bounds.northeast.lng),
//                                                 ),
//                                                 10,
//                                               )
//                                             : CameraUpdate.newCameraPosition(
//                                                 CameraPosition(
//                                                   target: LatLng(
//                                                     userCurrentLatLng.latitude,
//                                                     userCurrentLatLng.longitude,
//                                                   ),
//                                                   zoom: 10,
//                                                 ),
//                                               ),
//                                   );
//                                   setState(() {
//                                     if(isZoomDirection){
//                                       isZoomDirection = false;
//                                     } else {
//                                       isZoomDirection = true;
//                                     }
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   foregroundColor: AppStyle.colors.greyTxt,
//                                   backgroundColor: AppStyle.colors.textFieldColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.all(Radius.circular(2.r)),
//                                   ),
//                                 ),
//                                 child: Icon(
//                                   Icons.my_location_rounded,
//                                   color: AppStyle.colors.mapZoomBtnColor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             AnimatedContainer(
//               duration: const Duration(microseconds: 100),
//               curve: Curves.linear,
//               height: isDetailsOn ? 145.h : 0,
//               color: AppStyle.colors.textFieldColor,
//               padding: EdgeInsets.fromLTRB(20.w, 5.h, 13.w, 40.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: 255.w,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         /// 'Next Visit'
//                         AutoSizeText(
//                           'Next Visit',
//                           style: AppStyle.textStyle.textStyleLabel.copyWith(
//                             fontSize: 14.sp,
//                             color: AppStyle.colors.blackColor,
//                             fontWeight: FontWeight.w700,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           minFontSize: 14,
//                           maxLines: 1,
//                         ),
//                         /// Vehicle Title
//                         AutoSizeText(
//                           vehicleTitle,
//                           style: AppStyle.textStyle.textStyleLabel.copyWith(
//                             fontSize: 13.sp,
//                             color: AppStyle.colors.blackColor,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           minFontSize: 13,
//                           maxLines: 1,
//                         ),
//                         /// Vehicle Make & Vehicle Model
//                         AutoSizeText(
//                           '$vehicleMake | $vehicleModel',
//                           style: AppStyle.textStyle.textStyleLabel.copyWith(
//                             fontSize: 13.sp,
//                             color: AppStyle.colors.blackColor,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           minFontSize: 13,
//                           maxLines: 1,
//                         ),
//                         /// Vehicle Seller Name & Vehicle Seller Address
//                         AutoSizeText(
//                           '$vehicleSellerName | $vehicleSellerAddress',
//                           style: AppStyle.textStyle.textStyleLabel.copyWith(
//                             fontSize: 13.sp,
//                             color: AppStyle.colors.blackColor,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           minFontSize: 13,
//                           maxLines: 1,
//                         ),
//                         /// Vehicle Price
//                         AutoSizeText(
//                           vehicleIsPriceHide ? 'CONTACT SELLER FOR THE PRICE' : priceConvertor('$vehiclePrice'),
//                           style: AppStyle.textStyle.textStyleLabel.copyWith(
//                             fontSize: 13.sp,
//                             color: AppStyle.colors.blackColor,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                           minFontSize: 13,
//                           maxLines: 1,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 39.h,
//                     width: 97.w,
//                     child: ButtonFilled(
//                       text: 'NAVIGATE',
//                       onPress: () {
//                         OtherAppsLauncher.openNavigationGoogleMap(vehicleLat, vehicleLng);
//                       },
//                       isLoading: false,
//                       textStyle: AppStyle.textStyle.textStyle16.copyWith(fontSize: 13.sp),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   /// setInitialMarkers
//   _setInitialMarkers(LatLng userCurrentLatLngData, List<SellersLocationModel> sellersLocationList) async {
//     setState(() {
//       userMarker = Marker(
//         markerId: const MarkerId("you"),
//         icon: BitmapDescriptor.defaultMarker,
//         position: userCurrentLatLngData,
//         onTap: () {
//           _customInfoWindowSellerController.hideInfoWindow!();
//           _customInfoWindowUserController.addInfoWindow!(
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 43.h,
//                   width: 150.w,
//                   padding: EdgeInsets.fromLTRB(10.w, 2.h, 2.w, 6.h),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(8.r)),
//                     color: AppStyle.colors.textFieldColor,
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppStyle.colors.blackColor.withOpacity(0.3),
//                         offset: const Offset(0, 2),
//                         blurRadius: 10,
//                         spreadRadius: 1,
//                       ),
//                     ],
//                   ),
//                   child: Stack(
//                     children: [
//                       /// Clear Icon
//                       Align(
//                           alignment: Alignment.topRight,
//                           child: InkWell(
//                             onTap: (){
//                               _customInfoWindowUserController.hideInfoWindow!();
//                             },
//                             highlightColor: Colors.transparent,
//                             splashColor: Colors.transparent,
//                             child: Icon(
//                               Icons.clear_rounded,
//                               size: 16.r,
//                               color: AppStyle.colors.blackColor.withOpacity(0.7),
//                             ),
//                           ),
//                       ),
//                       /// 'My Location'
//                       Positioned(
//                         top: 11.h,
//                         child: Text(
//                           'My Location',
//                           style: AppStyle.textStyle.textStyleLabel.copyWith(
//                             fontSize: 12.sp,
//                             color: AppStyle.colors.blackColor.withOpacity(0.9),
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 /// Triangle
//                 Container(
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppStyle.colors.blackColor.withOpacity(0.1),
//                         offset: const Offset(0, 2),
//                         blurRadius: 16,
//                         spreadRadius: 0.5,
//                       ),
//                     ],
//                   ),
//                   child: CustomPaint(
//                     painter: TrianglePainter(
//                       strokeColor: AppStyle.colors.textFieldColor,
//                       strokeWidth: 15.w,
//                       paintingStyle: PaintingStyle.fill,
//                     ),
//                     child: SizedBox(
//                       height: 11.h,
//                       width: 18.w,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             userCurrentLatLngData,
//           );
//         },
//       );
//       _markers.add(userMarker);
//
//       for (int i = 0; i < sellersLocationList.length; i++) {
//         final Marker sellerMarker = Marker(
//           markerId: MarkerId('seller_${sellersLocationList[i].visitVehicleId}'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//           position: LatLng(
//             double.tryParse(sellersLocationList[i].visitVehicleLatitude)!,
//             double.tryParse(sellersLocationList[i].visitVehicleLongitude)!,
//           ),
//           onTap: () {
//             setState(() {
//               vehicleTitle = sellersLocationList[i].visitVehicleTitle;
//               vehicleMake = sellersLocationList[i].visitVehicleMake;
//               vehicleModel = sellersLocationList[i].visitVehicleModel;
//               vehicleSellerName = sellersLocationList[i].visitVehicleSellerName;
//               vehicleSellerAddress = sellersLocationList[i].visitVehicleSellerAddress;
//               vehiclePrice = sellersLocationList[i].visitVehiclePrice;
//               vehicleIsPriceHide = sellersLocationList[i].visitVehicleIsPriceHide;
//               vehicleLat = double.tryParse(sellersLocationList[i].visitVehicleLatitude)!;
//               vehicleLng = double.tryParse(sellersLocationList[i].visitVehicleLongitude)!;
//             });
//             context.read<GoogleMapDataBloc>().add(
//               GoogleMapDataRequested(
//                 param: GoogleMapDataParam(
//                   origin: '${userCurrentLatLng.latitude},${userCurrentLatLng.longitude}',
//                   destination: '${double.tryParse(sellersLocationList[i].visitVehicleLatitude)!},${double.tryParse(sellersLocationList[i].visitVehicleLongitude)!}',
//                   key: ApiEndpoints.googleMapAPIKey,
//                 ),
//               ),
//             );
//             _customInfoWindowUserController.hideInfoWindow!();
//             _customInfoWindowSellerController.addInfoWindow!(
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 57.h,
//                     width: 222.w,
//                     padding: EdgeInsets.fromLTRB(10.w, 2.h, 2.w, 6.h),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(8.r)),
//                       color: AppStyle.colors.textFieldColor,
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppStyle.colors.blackColor.withOpacity(0.3),
//                           offset: const Offset(0, 2),
//                           blurRadius: 10,
//                           spreadRadius: 1,
//                         ),
//                       ],
//                     ),
//                     child: Stack(
//                       children: [
//                         /// Clear Icon
//                         Align(
//                           alignment: Alignment.topRight,
//                           child: InkWell(
//                             onTap: (){
//                               _customInfoWindowSellerController.hideInfoWindow!();
//                             },
//                             highlightColor: Colors.transparent,
//                             splashColor: Colors.transparent,
//                             child: Icon(
//                               Icons.clear_rounded,
//                               size: 16.r,
//                               color: AppStyle.colors.blackColor.withOpacity(0.7),
//                             ),
//                           ),
//                         ),
//                         /// 'My Location'
//                         Positioned(
//                           top: 11.h,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 sellersLocationList[i].visitVehicleTitle,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: AppStyle.textStyle.textStyleLabel.copyWith(
//                                   fontSize: 12.sp,
//                                   color: AppStyle.colors.blackColor.withOpacity(0.9),
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               SizedBox(height: 4.h),
//                               Text(
//                                 sellersLocationList[i].visitVehicleSellerName,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: AppStyle.textStyle.textStyleLabel.copyWith(
//                                   fontSize: 11.sp,
//                                   color: AppStyle.colors.blackColor.withOpacity(0.6),
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   /// Triangle
//                   Container(
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppStyle.colors.blackColor.withOpacity(0.1),
//                           offset: const Offset(0, 2),
//                           blurRadius: 16,
//                           spreadRadius: 0.5,
//                         ),
//                       ],
//                     ),
//                     child: CustomPaint(
//                       painter: TrianglePainter(
//                         strokeColor: AppStyle.colors.textFieldColor,
//                         strokeWidth: 15.w,
//                         paintingStyle: PaintingStyle.fill,
//                       ),
//                       child: SizedBox(
//                         height: 11.h,
//                         width: 18.w,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               LatLng(
//                 double.tryParse(sellersLocationList[i].visitVehicleLatitude)!,
//                 double.tryParse(sellersLocationList[i].visitVehicleLongitude)!,
//               ),
//             );
//           },
//         );
//         _markers.add(sellerMarker);
//       }
//     });
//     getLiveLocation();
//   }
//
//   /// Get Live Location of User
//   Future<void> getLiveLocation() async {
//     if (Platform.isAndroid) {
//       locationSettings = AndroidSettings(
//         accuracy: LocationAccuracy.bestForNavigation,
//         distanceFilter: 0,
//         forceLocationManager: false,
//         intervalDuration: const Duration(seconds: 1),
//         /// (Optional) Set foreground notification config to keep the app alive
//         /// when going to the background
//         // foregroundNotificationConfig: const ForegroundNotificationConfig(
//         //   notificationText: "Example app will continue to receive your location even when you aren't using it",
//         //   notificationTitle: "Running in Background",
//         //   enableWakeLock: true,
//         // ),
//       );
//     }
//     else if (Platform.isIOS || Platform.isMacOS) {
//       locationSettings = AppleSettings(
//         accuracy: LocationAccuracy.bestForNavigation,
//         activityType: ActivityType.automotiveNavigation,
//         distanceFilter: 0,
//         allowBackgroundLocationUpdates: true,
//         pauseLocationUpdatesAutomatically: false,
//         /// Only set to true if our app will be started up in the background.
//         showBackgroundLocationIndicator: false,
//       );
//     }
//     else {
//       locationSettings = const LocationSettings(
//         accuracy: LocationAccuracy.bestForNavigation,
//         distanceFilter: 0,
//       );
//     }
//
//     locationSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
//       setState((){
//         userCurrentLatLng = LatLng(position?.latitude ?? 0.0, position?.longitude ?? 0.0);
//         userMarker = Marker(
//           markerId: const MarkerId("you"),
//           icon: BitmapDescriptor.defaultMarker,
//           position: userCurrentLatLng,
//           onTap: () {
//             _customInfoWindowSellerController.hideInfoWindow!();
//             _customInfoWindowUserController.addInfoWindow!(
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 43.h,
//                     width: 150.w,
//                     padding: EdgeInsets.fromLTRB(10.w, 2.h, 2.w, 6.h),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(8.r)),
//                       color: AppStyle.colors.textFieldColor,
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppStyle.colors.blackColor.withOpacity(0.3),
//                           offset: const Offset(0, 2),
//                           blurRadius: 10,
//                           spreadRadius: 1,
//                         ),
//                       ],
//                     ),
//                     child: Stack(
//                       children: [
//                         /// Clear Icon
//                         Align(
//                           alignment: Alignment.topRight,
//                           child: InkWell(
//                             onTap: (){
//                               _customInfoWindowUserController.hideInfoWindow!();
//                             },
//                             highlightColor: Colors.transparent,
//                             splashColor: Colors.transparent,
//                             child: Icon(
//                               Icons.clear_rounded,
//                               size: 16.r,
//                               color: AppStyle.colors.blackColor.withOpacity(0.7),
//                             ),
//                           ),
//                         ),
//                         /// 'My Location'
//                         Positioned(
//                           top: 11.h,
//                           child: Text(
//                             'My Location',
//                             style: AppStyle.textStyle.textStyleLabel.copyWith(
//                               fontSize: 12.sp,
//                               color: AppStyle.colors.blackColor.withOpacity(0.9),
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   /// Triangle
//                   Container(
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppStyle.colors.blackColor.withOpacity(0.1),
//                           offset: const Offset(0, 2),
//                           blurRadius: 16,
//                           spreadRadius: 0.5,
//                         ),
//                       ],
//                     ),
//                     child: CustomPaint(
//                       painter: TrianglePainter(
//                         strokeColor: AppStyle.colors.textFieldColor,
//                         strokeWidth: 15.w,
//                         paintingStyle: PaintingStyle.fill,
//                       ),
//                       child: SizedBox(
//                         height: 11.h,
//                         width: 18.w,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               userCurrentLatLng,
//             );
//           },
//         );
//         _markers.add(userMarker);
//       });
//     });
//   }
// }
