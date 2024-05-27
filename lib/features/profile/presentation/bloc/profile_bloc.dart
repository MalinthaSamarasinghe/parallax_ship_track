import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/user_name_usecase.dart';
import '../../domain/usecase/user_email_usecase.dart';
import '../../../../core/blocs/event_transformer.dart';
import '../../domain/usecase/user_profile_image_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserNameUseCase userNameUseCase;
  final UserEmailUseCase userEmailUseCase;
  final UserProfileImageUseCase userProfileImageUseCase;

  ProfileBloc({
    required this.userNameUseCase,
    required this.userEmailUseCase,
    required this.userProfileImageUseCase,
  }) : super(const ProfileState()) {
    on<UpdateNameChanged>(_onUpdateNameChanged, transformer: Transformer.throttleDroppable());
    on<UpdateEmailChanged>(_onUpdateEmailChanged, transformer: Transformer.throttleDroppable());
    on<UpdateProfileImgChanged>(_onUpdateProfileImgChanged, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _onUpdateNameChanged(UpdateNameChanged event, Emitter<ProfileState> emit) async {
    Either<Failure, firebase_auth.User> result = await userNameUseCase(event.name);
    result.fold(
      (failure) {
        String message = '';
        if (failure is ServerFailure) {
          message = failure.message;
        } else if (failure is NoConnectionFailure) {
          message = 'Please check your internet connection and try again!';
        } else {
          message = 'Something went wrong. Please try again later!';
        }
        emit(state.copyWith(
          profileStatus: ProfileStatus.failure,
          errorMessage: message,
        ));
      },
      (data) {
        emit(state.copyWith(
          profileStatus: ProfileStatus.success,
          user: data,
        ));
      },
    );
  }

  FutureOr<void> _onUpdateEmailChanged(UpdateEmailChanged event, Emitter<ProfileState> emit) async {
    Either<Failure, firebase_auth.User> result = await userEmailUseCase(event.email);
    result.fold(
      (failure) {
        String message = '';
        if (failure is ServerFailure) {
          message = failure.message;
        } else if (failure is NoConnectionFailure) {
          message = 'Please check your internet connection and try again!';
        } else {
          message = 'Something went wrong. Please try again later!';
        }
        emit(state.copyWith(
          profileStatus: ProfileStatus.failure,
          errorMessage: message,
        ));
      },
      (data) {
        emit(state.copyWith(
          profileStatus: ProfileStatus.success,
          user: data,
        ));
      },
    );
  }

  FutureOr<void> _onUpdateProfileImgChanged(UpdateProfileImgChanged event, Emitter<ProfileState> emit) async {
    Either<Failure, firebase_auth.User> result = await userProfileImageUseCase(event.profileImg);
    result.fold(
      (failure) {
        String message = '';
        if (failure is ServerFailure) {
          message = failure.message;
        } else if (failure is NoConnectionFailure) {
          message = 'Please check your internet connection and try again!';
        } else {
          message = 'Something went wrong. Please try again later!';
        }
        emit(state.copyWith(
          profileStatus: ProfileStatus.failure,
          errorMessage: message,
        ));
      },
      (data) {
        emit(state.copyWith(
          profileStatus: ProfileStatus.success,
          user: data,
        ));
      },
    );
  }
}
