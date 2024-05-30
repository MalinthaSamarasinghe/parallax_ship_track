import 'dart:io';
import 'dart:async';
import 'triangle_painter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/vertical_divider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/presentation/buttons/main_button.dart';

class GoogleMapWidget extends StatefulWidget {
  final Position userCurrentLocationData;
  final LatLng orderCurrentLocationData;

  const GoogleMapWidget({
    super.key,
    required this.userCurrentLocationData,
    required this.orderCurrentLocationData,
  });

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final CustomInfoWindowController _customInfoWindowUserController = CustomInfoWindowController();
  final CustomInfoWindowController _customInfoWindowOrderController = CustomInfoWindowController();
  final Completer<GoogleMapController?> _googleMapController = Completer();
  late GoogleMapController _googleMapViewController;
  StreamSubscription<Position>? locationSubscription;
  late LocationAccuracyStatus accuracyStatus;
  late LocationSettings locationSettings;
  late LatLng userCurrentLatLng;
  late LatLng orderCurrentLatLng;
  late Marker userMarker;

  bool isNormalMapType = true;
  bool isZoomDirection = false;
  bool isDetailsOn = false;
  final Set<Marker> _markers = {};
  String vehicleNumber = 'N/A';
  String driverContactNumber = 'N/A';
  String orderID = 'N/A';
  String customerAddress = 'N/A';
  String notes = 'N/A';

  @override
  void initState() {
    setState(() {
      userCurrentLatLng = LatLng(widget.userCurrentLocationData.latitude, widget.userCurrentLocationData.longitude);
      orderCurrentLatLng = LatLng(widget.orderCurrentLocationData.latitude, widget.orderCurrentLocationData.longitude);
    });
    _setInitialMarkers(userCurrentLatLng, orderCurrentLatLng);
    super.initState();
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    _googleMapViewController.dispose();
    _customInfoWindowUserController.dispose();
    _customInfoWindowOrderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) {
                  _googleMapViewController = controller;
                  _googleMapController.complete(controller);
                  _customInfoWindowUserController.googleMapController = controller;
                  _customInfoWindowOrderController.googleMapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    widget.userCurrentLocationData.latitude,
                    widget.userCurrentLocationData.longitude,
                  ),
                  zoom: 10,
                ),
                onCameraMove: (position) {
                  _customInfoWindowUserController.onCameraMove!();
                  _customInfoWindowOrderController.onCameraMove!();
                },
                onTap: (position) {
                  _customInfoWindowUserController.hideInfoWindow!();
                  _customInfoWindowOrderController.hideInfoWindow!();
                },
                markers: _markers,
                mapType: isNormalMapType ? MapType.normal : MapType.satellite,
                compassEnabled: false,
                mapToolbarEnabled: false,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
              ),
              /// CustomInfoWindow for User
              CustomInfoWindow(
                controller: _customInfoWindowUserController,
                offset: 36.h,
                height: 64.h,
                width: 150.w,
              ),
              /// CustomInfoWindow for Sellers
              CustomInfoWindow(
                controller: _customInfoWindowOrderController,
                offset: 44.h,
                height: 70.h,
                width: 222.w,
              ),
              /// Button To Change Map Type
              Positioned(
                top: 10.w,
                right: 10.w,
                child: ButtonBar(
                  buttonPadding: EdgeInsets.zero,
                  buttonTextTheme: ButtonTextTheme.primary,
                  alignment: MainAxisAlignment.start,
                  children: <Widget>[
                    /// Map Type Button
                    Opacity(
                      opacity: 0.8,
                      child: Container(
                        height: 42.h,
                        width: 78.w,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2.r),
                            bottomLeft: Radius.circular(2.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: const Offset(0, 2),
                              blurRadius: 0.5,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if(isNormalMapType == false){
                                isNormalMapType = true;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.grey,
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(2.r),
                                bottomLeft: Radius.circular(2.r),
                              ),
                            ),
                          ),
                          child: Text(
                            'Map',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: isNormalMapType ? Colors.black : Colors.black.withOpacity(0.6),
                              fontWeight: isNormalMapType ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    /// Custom VerticalDivider
                    Opacity(
                      opacity: 0.8,
                      child: SizedBox(
                        height: 20.h,
                        width: 0.5.w,
                        child: const VerticalDividerContainer(),
                      ),
                    ),
                    /// Satellite Type Button
                    Opacity(
                      opacity: 0.8,
                      child: Container(
                        height: 42.h,
                        width: 105.w,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(2.r),
                            bottomRight: Radius.circular(2.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: const Offset(0, 2),
                              blurRadius: 0.5,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if(isNormalMapType == true){
                                isNormalMapType = false;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.grey,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(2.r),
                                bottomRight: Radius.circular(2.r),
                              ),
                            ),
                          ),
                          child: Text(
                            'Satellite',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: !isNormalMapType ? Colors.black : Colors.black.withOpacity(0.6),
                              fontWeight: !isNormalMapType ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /// button to zoom
              Positioned(
                top: 60.h,
                right: 10.w,
                child: ButtonBar(
                  buttonPadding: EdgeInsets.zero,
                  buttonTextTheme: ButtonTextTheme.primary,
                  alignment: MainAxisAlignment.start,
                  children: <Widget>[
                    /// zoom Button
                    Opacity(
                      opacity: 0.8,
                      child: Container(
                        height: 38.w,
                        width: 38.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(2.r)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: const Offset(0, 2),
                              blurRadius: 0.5,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              _googleMapViewController.animateCamera(
                                isZoomDirection
                                    ? CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: LatLng(
                                            userCurrentLatLng.latitude,
                                            userCurrentLatLng.longitude,
                                          ),
                                          zoom: 10,
                                        ),
                                      )
                                    : CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                      userCurrentLatLng.latitude,
                                      userCurrentLatLng.longitude,
                                    ),
                                    zoom: 10,
                                  ),
                                ),
                              );
                              setState(() {
                                if(isZoomDirection){
                                  isZoomDirection = false;
                                } else {
                                  isZoomDirection = true;
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.grey,
                              backgroundColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(2.r)),
                              ),
                            ),
                            child: Icon(
                              Icons.my_location_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(microseconds: 100),
          curve: Curves.linear,
          height: isDetailsOn ? 145.h : 0,
          color: Colors.grey,
          padding: EdgeInsets.fromLTRB(20.w, 5.h, 13.w, 40.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 255.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 'Next Visit'
                    AutoSizeText(
                      'Next Visit',
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 14,
                      maxLines: 1,
                    ),
                    /// Vehicle Title
                    AutoSizeText(
                      vehicleNumber,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 13,
                      maxLines: 1,
                    ),
                    /// Vehicle Make & Vehicle Model
                    AutoSizeText(
                      '$driverContactNumber | $orderID',
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 13,
                      maxLines: 1,
                    ),
                    /// Vehicle Seller Name & Vehicle Seller Address
                    AutoSizeText(
                      '$customerAddress | $notes',
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 13,
                      maxLines: 1,
                    ),
                    /// Vehicle Price
                    AutoSizeText(
                      'CONTACT SELLER FOR THE PRICE',
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 13,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 39.h,
                width: 97.w,
                child: MainButton(
                  title: 'NAVIGATE',
                  onPressed: () {  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// setInitialMarkers
  _setInitialMarkers(LatLng userCurrentLatLngData, LatLng orderCurrentLatLngData) async {
    setState(() {
      userMarker = Marker(
        markerId: const MarkerId("you"),
        icon: BitmapDescriptor.defaultMarker,
        position: userCurrentLatLngData,
        onTap: () {
          _customInfoWindowOrderController.hideInfoWindow!();
          _customInfoWindowUserController.addInfoWindow!(
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 43.h,
                  width: 150.w,
                  padding: EdgeInsets.fromLTRB(10.w, 2.h, 2.w, 6.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    color: Colors.yellow,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow,
                        offset: const Offset(0, 2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      /// Clear Icon
                      Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: (){
                              _customInfoWindowUserController.hideInfoWindow!();
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Icon(
                              Icons.clear_rounded,
                              size: 16.r,
                              color: Colors.black,
                            ),
                          ),
                      ),
                      /// 'My Location'
                      Positioned(
                        top: 11.h,
                        child: Text(
                          'My Location',
                        ),
                      ),
                    ],
                  ),
                ),
                /// Triangle
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [

                    ],
                  ),
                  child: CustomPaint(
                    painter: TrianglePainter(
                      strokeColor: Colors.grey,
                      strokeWidth: 15.w,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    child: SizedBox(
                      height: 11.h,
                      width: 18.w,
                    ),
                  ),
                ),
              ],
            ),
            userCurrentLatLngData,
          );
        },
      );
      _markers.add(userMarker);

      final Marker orderMarker = Marker(
        markerId: MarkerId('orderMarker'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: LatLng(
          orderCurrentLatLngData.latitude,
          orderCurrentLatLngData.longitude,
        ),
        onTap: () {
          _customInfoWindowUserController.hideInfoWindow!();
          _customInfoWindowOrderController.addInfoWindow!(
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 57.h,
                  width: 222.w,
                  padding: EdgeInsets.fromLTRB(10.w, 2.h, 2.w, 6.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    color: Colors.yellow,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: const Offset(0, 2),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      /// Clear Icon
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: (){
                            _customInfoWindowOrderController.hideInfoWindow!();
                          },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Icon(
                            Icons.clear_rounded,
                            size: 16.r,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      /// 'My Location'
                      Positioned(
                        top: 11.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'sellersLocationList[i].visitVehicleTitle',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,

                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'sellersLocationList[i].visitVehicleSellerName',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /// Triangle
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: const Offset(0, 2),
                        blurRadius: 16,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                  child: CustomPaint(
                    painter: TrianglePainter(
                      strokeColor: Colors.black,
                      strokeWidth: 15.w,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    child: SizedBox(
                      height: 11.h,
                      width: 18.w,
                    ),
                  ),
                ),
              ],
            ),
              orderCurrentLatLngData,
          );
        },
      );
      _markers.add(orderMarker);
    });
    getLiveLocation();
  }

  /// Get Live Location of User
  Future<void> getLiveLocation() async {
    if (Platform.isAndroid) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
        forceLocationManager: false,
        intervalDuration: const Duration(seconds: 1),
        /// (Optional) Set foreground notification config to keep the app alive
        /// when going to the background
        // foregroundNotificationConfig: const ForegroundNotificationConfig(
        //   notificationText: "Example app will continue to receive your location even when you aren't using it",
        //   notificationTitle: "Running in Background",
        //   enableWakeLock: true,
        // ),
      );
    }
    else if (Platform.isIOS || Platform.isMacOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        activityType: ActivityType.automotiveNavigation,
        distanceFilter: 0,
        allowBackgroundLocationUpdates: true,
        pauseLocationUpdatesAutomatically: false,
        /// Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    }
    else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      );
    }

    locationSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
      setState((){
        userCurrentLatLng = LatLng(position?.latitude ?? 0.0, position?.longitude ?? 0.0);
        userMarker = Marker(
          markerId: const MarkerId("you"),
          icon: BitmapDescriptor.defaultMarker,
          position: userCurrentLatLng,
          onTap: () {
            _customInfoWindowOrderController.hideInfoWindow!();
            _customInfoWindowUserController.addInfoWindow!(
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 43.h,
                    width: 150.w,
                    padding: EdgeInsets.fromLTRB(10.w, 2.h, 2.w, 6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(0, 2),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        /// Clear Icon
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: (){
                              _customInfoWindowUserController.hideInfoWindow!();
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Icon(
                              Icons.clear_rounded,
                              size: 16.r,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        /// 'My Location'
                        Positioned(
                          top: 11.h,
                          child: Text(
                            'My Location',
                          ),
                        ),
                      ],
                    ),
                  ),
                  /// Triangle
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(0, 2),
                          blurRadius: 16,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                    child: CustomPaint(
                      painter: TrianglePainter(
                        strokeColor: Colors.black,
                        strokeWidth: 15.w,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      child: SizedBox(
                        height: 11.h,
                        width: 18.w,
                      ),
                    ),
                  ),
                ],
              ),
              userCurrentLatLng,
            );
          },
        );
        _markers.add(userMarker);
      });
    });
  }
}
