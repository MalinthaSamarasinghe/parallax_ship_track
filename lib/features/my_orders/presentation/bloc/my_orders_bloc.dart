import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/blocs/event_transformer.dart';
import '../../../dashboard/domain/entities/dashboard_statistics_entity.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_database;

part 'my_orders_event.dart';
part 'my_orders_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrdersState> {

  MyOrdersBloc() : super(const MyOrdersState()) {
    on<MyOrdersChanged>(_myOrdersChanged, transformer: Transformer.throttleDroppable());
  }

  void _myOrdersChanged(MyOrdersChanged event, Emitter<MyOrdersState> emit) {
    if (event.data!.snapshot.exists) {
      List<DashboardStatisticsEntity>? data = [];
      try{
        for (final child in event.data!.snapshot.children) {
          /// cast the snapshot value to a Map
          Map<String, dynamic> myOrdersObj = Map<String, dynamic>.from(child.value as Map);
          String name = myOrdersObj['Name'];
          String value = myOrdersObj['Value'];
          String mainCategory = myOrdersObj['Main_Category'];
          String imagePath = myOrdersObj['Image_URL'];
          data.add(DashboardStatisticsEntity(
            name: name,
            value: value,
            mainCategory: mainCategory,
            imagePath: imagePath,
          ));
        }
        debugPrint("MyOrdersChanged data --> snapshot: $data");
        emit(state.copyWith(
          status: MyOrdersStatus.success,
          myOrdersData: data,
        ));
      } catch (e) {
        debugPrint("MyOrdersChanged error: $e");
        emit(state.copyWith(
          status: MyOrdersStatus.failure,
          myOrdersData: [],
          errorMessage: e.toString(),
        ));
      }
    } else {
      emit(state.copyWith(
        status: MyOrdersStatus.success,
        myOrdersData: state.myOrdersData,
      ));
      debugPrint("MyOrdersChanged data --> snapshot: ${state.myOrdersData}");
    }
  }
}
