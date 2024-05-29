import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/blocs/event_transformer.dart';
import '../../domain/entities/dashboard_statistics_entity.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_database;

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  DashboardBloc() : super(const DashboardState()) {
    on<DashboardOrderStatisticsChanged>(_dashboardOrderStatisticsChanged, transformer: Transformer.throttleDroppable());
    on<DashboardFinanceStatisticsChanged>(_dashboardFinanceStatisticsChanged, transformer: Transformer.throttleDroppable());
  }

  void _dashboardOrderStatisticsChanged(DashboardOrderStatisticsChanged event, Emitter<DashboardState> emit) {
    if (event.data!.snapshot.exists) {
      List<DashboardStatisticsEntity>? data = [];
      try {
        for (final child in event.data!.snapshot.children) {
          /// cast the snapshot value to a Map
          Map<String, dynamic> dashboardOrderStatisticsObj = Map<String, dynamic>.from(child.value as Map);
          String name = dashboardOrderStatisticsObj['Name'];
          String value = dashboardOrderStatisticsObj['Value'];
          String mainCategory = dashboardOrderStatisticsObj['Main_Category'];
          String imagePath = dashboardOrderStatisticsObj['Image_URL'];
          data.add(DashboardStatisticsEntity(
            name: name,
            value: value,
            mainCategory: mainCategory,
            imagePath: imagePath,
          ));
        }
        debugPrint("DashboardOrderStatisticsChanged data --> snapshot: $data");
        emit(state.copyWith(
          status: DashboardStatus.success,
          dashboardOrderStatisticsData: data,
        ));
      } catch (e) {
        debugPrint("DashboardOrderStatisticsChanged error: $e");
        emit(state.copyWith(
          status: DashboardStatus.failure,
          dashboardOrderStatisticsData: [],
          errorMessage: e.toString(),
        ));
      }
    } else {
      emit(state.copyWith(
        status: DashboardStatus.success,
        dashboardOrderStatisticsData: state.dashboardOrderStatisticsData,
      ));
      debugPrint("DashboardOrderStatisticsChanged data --> snapshot: ${state.dashboardOrderStatisticsData}");
    }
  }

  void _dashboardFinanceStatisticsChanged(DashboardFinanceStatisticsChanged event, Emitter<DashboardState> emit) {
    if (event.data!.snapshot.exists) {
      List<DashboardStatisticsEntity>? data = [];
      try{
        for (final child in event.data!.snapshot.children) {
          /// cast the snapshot value to a Map
          Map<String, dynamic> dashboardFinanceStatisticsObj = Map<String, dynamic>.from(child.value as Map);
          String name = dashboardFinanceStatisticsObj['Name'];
          String value = dashboardFinanceStatisticsObj['Value'];
          String mainCategory = dashboardFinanceStatisticsObj['Main_Category'];
          String imagePath = dashboardFinanceStatisticsObj['Image_URL'];
          data.add(DashboardStatisticsEntity(
            name: name,
            value: value,
            mainCategory: mainCategory,
            imagePath: imagePath,
          ));
        }
        debugPrint("DashboardFinanceStatisticsChanged data --> snapshot: $data");
        emit(state.copyWith(
          dashboardFinanceStatisticsData: data,
        ));
      } catch (e) {
        debugPrint("DashboardFinanceStatisticsChanged error: $e");
        emit(state.copyWith(
          status: DashboardStatus.failure,
          dashboardFinanceStatisticsData: [],
          errorMessage: e.toString(),
        ));
      }
    } else {
      emit(state.copyWith(
        status: DashboardStatus.success,
        dashboardFinanceStatisticsData: state.dashboardFinanceStatisticsData,
      ));
      debugPrint("DashboardFinanceStatisticsChanged data --> snapshot: ${state.dashboardFinanceStatisticsData}");
    }
  }
}
