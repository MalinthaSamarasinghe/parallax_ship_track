import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/blocs/event_transformer.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_database;

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  DashboardBloc() : super(const DashboardState()) {
    on<DashboardDataChanged>(_dashboardDataChanged, transformer: Transformer.throttleDroppable());
  }

  void _dashboardDataChanged(DashboardDataChanged event, Emitter<DashboardState> emit) {
    if (event.data!.snapshot.exists) {
      List<DashboardParams>? data = [];
      for (final child in event.data!.snapshot.children) {
        /// cast the snapshot value to a Map
        Map<String, dynamic> dashboardData = Map<String, dynamic>.from(child.value as Map);
        String staticCategory = dashboardData['staticCategory'];
        String staticType = dashboardData['staticType'];
        String value = dashboardData['value'];
        data.add(DashboardParams(
          uid: child.key ?? 'unknown_uid',
          staticCategory: staticCategory,
          staticType: staticType,
          value: value,
        ));
      }
      debugPrint("DashboardDataChanged data --> snapshot: $data");
      emit(state.copyWith(
        data: data,
      ));
    } else {
      emit(state.copyWith(
        data: [],
      ));
      debugPrint("DashboardDataChanged data --> snapshot: ${state.data}");
    }
  }
}
