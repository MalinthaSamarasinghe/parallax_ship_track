import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/blocs/event_transformer.dart';
import '../../domain/usecase/forgot_password_usecase.dart';
import '../../../../core/models/form_inputs/email_formz_model.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  /// TextEditingController
  final TextEditingController emailController = TextEditingController();

  /// FocusNode
  final FocusNode emailNode = FocusNode();

  @override
  Future<void> close() {
    emailController.dispose();
    emailNode.dispose();
    return super.close();
  }

  ForgotPasswordBloc({
    required this.forgotPasswordUseCase,
  }) : super(const ForgotPasswordState()) {
    on<ForgotEmailRequested>(_onForgotEmailRequested);
    on<ForgotPasswordLinkRequested>(_onForgotPasswordLinkRequested, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _onForgotEmailRequested(ForgotEmailRequested event, Emitter<ForgotPasswordState> emit) {
    final email = EmailFormzModel.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([email]),
      ),
    );
  }

  FutureOr<void> _onForgotPasswordLinkRequested(ForgotPasswordLinkRequested event, Emitter<ForgotPasswordState> emit) async {
    if (state.status == FormzSubmissionStatus.failure) {
      emit(state.copyWith(
        isValid: Formz.validate([state.email]),
      ));
    }

    if (state.status == FormzSubmissionStatus.initial || !state.isValid) {
      final email = EmailFormzModel.dirty(state.email.value);

      emit(state.copyWith(
        email: email,
        isValid: Formz.validate([email]),
      ));
    }

    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      Either<Failure, String> result = await forgotPasswordUseCase(state.email.value);
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
            status: FormzSubmissionStatus.failure,
            errorMessage: message,
          ));
        },
        (userCredential) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            successMessage: userCredential,
          ));
        },
      );
    }
  }
}
