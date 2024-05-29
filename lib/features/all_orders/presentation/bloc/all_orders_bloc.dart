import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/all_orders_entity.dart';
import '../../../../core/blocs/event_transformer.dart';
import '../../domain/entities/all_orders_remark_entity.dart';
import '../../domain/entities/all_orders_merchant_entity.dart';
import '../../domain/entities/all_orders_tracking_entity.dart';
import '../../domain/entities/all_orders_customer_entity.dart';
import '../../domain/entities/all_orders_order_history_entity.dart';
import '../../domain/entities/all_orders_invoice_history_entity.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_database;

part 'all_orders_event.dart';
part 'all_orders_state.dart';

class AllOrdersBloc extends Bloc<AllOrdersEvent, AllOrdersState> {

  AllOrdersBloc() : super(const AllOrdersState()) {
    on<AllOrdersChanged>(_allOrdersChanged, transformer: Transformer.throttleDroppable());
  }

  void _allOrdersChanged(AllOrdersChanged event, Emitter<AllOrdersState> emit) {
    if (event.data!.snapshot.exists) {
      List<AllOrdersEntity>? data = [];
      /// TODO: Error handling --> I/flutter ( 5816): AllOrdersChanged error: type 'List<Object?>' is not a subtype of type 'Map<dynamic, dynamic>' in type cast
      try{
        for (final child in event.data!.snapshot.children) {
          /// cast the snapshot value to a Map
          Map<String, dynamic> allOrdersObj = Map<String, dynamic>.from(child.value as Map);
          Map<String, dynamic> customerDetailsObj = Map<String, dynamic>.from(allOrdersObj['Customer_Details'] as Map);
          Map<String, dynamic> generalRemarkObj = Map<String, dynamic>.from(allOrdersObj['General_Remark'] as Map);
          Map<String, dynamic> invoiceHistoryObj = Map<String, dynamic>.from(allOrdersObj['Invoice_History'] as Map);
          Map<String, dynamic> merchantDetailsObj = Map<String, dynamic>.from(allOrdersObj['Merchant_Details'] as Map);
          Map<String, dynamic> orderHistoryObj = Map<String, dynamic>.from(allOrdersObj['Order_History'] as Map);
          Map<String, dynamic> trackingObj = Map<String, dynamic>.from(allOrdersObj['Tracking'] as Map);

          String cod = allOrdersObj['COD'];
          String code = allOrdersObj['Code'];
          String createdOn = allOrdersObj['Created_On'];
          String status = allOrdersObj['Status'];
          String updatedAt = allOrdersObj['Updated_At'];
          String weight = allOrdersObj['Weight'];
          String customerAddress = customerDetailsObj['Customer_Address'];
          String customerCity = customerDetailsObj['Customer_City'];
          String customerImage = customerDetailsObj['Customer_Image'];
          String customerMail = customerDetailsObj['Customer_Mail'];
          String customerName = customerDetailsObj['Customer_Name'];
          String customerNumber = customerDetailsObj['Customer_Number'];
          String customerWarehouse = customerDetailsObj['Customer_Warehouse'];
          String merchantAddress = merchantDetailsObj['Merchant_Address'];
          String merchantCity = merchantDetailsObj['Merchant_City'];
          String merchantId = merchantDetailsObj['Merchant_Id'];
          String merchantImage = merchantDetailsObj['Merchant_Image'];
          String merchantName = merchantDetailsObj['Merchant_Name'];
          String merchantWearHouse = merchantDetailsObj['Merchant_Warehouse'];
          String latitude = trackingObj['Latitude'];
          String longitude = trackingObj['Longitude'];

          List<Map<String, dynamic>> generalRemarks = [];
          generalRemarkObj.forEach((key, value) {
            if (value is Map) {
              generalRemarks.add(Map<String, dynamic>.from(value));
            }
          });
          List<Map<String, dynamic>> invoiceHistory = [];
          invoiceHistoryObj.forEach((key, value) {
            if (value is Map) {
              invoiceHistory.add(Map<String, dynamic>.from(value));
            }
          });
          List<Map<String, dynamic>> orderHistory = [];
          orderHistoryObj.forEach((key, value) {
            if (value is Map) {
              orderHistory.add(Map<String, dynamic>.from(value));
            }
          });

          data.add(AllOrdersEntity(
            cod: cod,
            code: code,
            createdOn: createdOn,
            status: status,
            updatedAt: updatedAt,
            weight: weight,
            allOrdersCustomerData: AllOrdersCustomerEntity(
              customerAddress: customerAddress,
              customerCity: customerCity,
              customerImage: customerImage,
              customerMail: customerMail,
              customerName: customerName,
              customerNumber: customerNumber,
              customerWearHouse: customerWarehouse,
            ),
            allOrdersRemarkData: generalRemarks.map((remark) => AllOrdersRemarkEntity(
              readBy: remark['Read_By'],
              remark: remark['Remark'],
              remarkDate: remark['Remark_Date'],
              remarkedBy: remark['Remarked_By'],
              tag: remark['Tag'],
            )).toList(),
            allOrdersInvoiceHistoryData: invoiceHistory.map((invoice) => AllOrdersInvoiceHistoryEntity(
              invoiceHistoryAmount: invoice['Invoice_History_Amount'],
              invoiceHistoryType: invoice['Invoice_History_Type'],
              invoiceHistoryUserOne: invoice['Invoice_History_User_One'],
              invoiceHistoryUserTwo: invoice['Invoice_History_User_Two'],
            )).toList(),
            allOrdersMerchantData: AllOrdersMerchantEntity(
              merchantAddress: merchantAddress,
              merchantCity: merchantCity,
              merchantId: merchantId,
              merchantImage: merchantImage,
              merchantName: merchantName,
              merchantWearHouse: merchantWearHouse,
            ),
            allOrdersOrderHistoryData: orderHistory.map((order) => AllOrdersOrderHistoryEntity(
              orderHistoryMessage: order['Order_History_Message'],
              orderHistoryType: order['Order_History_Type'],
              orderHistoryUserOne: order['Order_History_User_One'],
              orderHistoryUserTwo: order['Order_History_User_Two'],
            )).toList(),
            allOrdersTrackingData: AllOrdersTrackingEntity(
              latitude: double.parse(latitude),
              longitude: double.parse(longitude),
            ),
          ));
        }
        debugPrint("AllOrdersChanged data --> snapshot: $data");
        emit(state.copyWith(
          status: AllOrdersStatus.success,
          allOrdersData: data,
        ));
      } catch (e) {
        debugPrint("AllOrdersChanged error: $e");
        emit(state.copyWith(
          status: AllOrdersStatus.failure,
          allOrdersData: [],
          errorMessage: e.toString(),
        ));
      }
    } else {
      emit(state.copyWith(
        status: AllOrdersStatus.success,
        allOrdersData: state.allOrdersData,
      ));
      debugPrint("AllOrdersChanged data --> snapshot: ${state.allOrdersData}");
    }
  }
}
