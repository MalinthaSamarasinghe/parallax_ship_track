import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/blocs/event_transformer.dart';
import '../../domain/usecase/password_login_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../../core/models/form_inputs/email_formz_model.dart';
import '../../../../core/models/form_inputs/common_formz_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PasswordLoginUseCase passwordLoginUser;

  /// TextEditingController
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// FocusNode
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    return super.close();
  }

  LoginBloc({
    required this.passwordLoginUser,
  }) : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordLoginRequested>(_onPasswordLoginRequested, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = EmailFormzModel.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
        loginStatus: LoginStatus.unknown,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  FutureOr<void> _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = CommonFormzModel.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
        loginStatus: LoginStatus.unknown,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  FutureOr<void> _onPasswordLoginRequested(PasswordLoginRequested event, Emitter<LoginState> emit) async {
    if (state.status == FormzSubmissionStatus.failure) {
      emit(state.copyWith(
        isValid: Formz.validate([state.email, state.password]),
      ));
    }

    if (state.status == FormzSubmissionStatus.initial || !state.isValid) {
      final email = EmailFormzModel.dirty(state.email.value);
      final password = CommonFormzModel.dirty(state.password.value);

      emit(state.copyWith(
        email: email,
        password: password,
        isValid: Formz.validate([email, password]),
      ));
    }

    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      LoginDetails loginDetails = LoginDetails(
        email: state.email.value,
        password: state.password.value,
      );
      debugPrint('LoginDetails --> $loginDetails');
      Either<Failure, firebase_auth.UserCredential> result = await passwordLoginUser(loginDetails);
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
            userCredential: userCredential,
          ));
        },
      );
    }
  }
}
