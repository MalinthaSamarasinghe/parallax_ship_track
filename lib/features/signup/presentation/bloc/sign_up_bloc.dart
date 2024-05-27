import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/signup_usecase.dart';
import '../../../../core/blocs/event_transformer.dart';
import '../../../../core/models/form_inputs/name_form_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../../core/models/form_inputs/email_formz_model.dart';
import '../../../../core/models/form_inputs/password_formz_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  /// TextEditingController
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmedPasswordController = TextEditingController();

  /// FocusNode
  final FocusNode nameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode confirmedPasswordNode = FocusNode();

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmedPasswordController.dispose();
    nameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    confirmedPasswordNode.dispose();
    return super.close();
  }

  SignUpBloc({required this.signUpUseCase}) : super(const SignUpState()) {
    on<GetNameChanged>(_onGetNameChanged);
    on<GetEmailChanged>(_onGetEmailChanged);
    on<GetPasswordChanged>(_onGetPasswordChanged);
    on<GetConfirmedPasswordChanged>(_onGetConfirmedPasswordChanged);
    on<GetAccountCreationRequested>(_onGetAccountCreationRequested, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _onGetNameChanged(GetNameChanged event, Emitter<SignUpState> emit) {
    final name = NameFormzModel.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([name, state.email, state.password, state.confirmedPassword]),
      ),
    );
  }

  FutureOr<void> _onGetEmailChanged(GetEmailChanged event, Emitter<SignUpState> emit) {
    final email = EmailFormzModel.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([state.name, email, state.password, state.confirmedPassword]),
      ),
    );
  }

  FutureOr<void> _onGetPasswordChanged(GetPasswordChanged event, Emitter<SignUpState> emit) {
    final password = PasswordFormzModel.dirty(PasswordParameters(
      isPasswordField: true,
      password: event.passWord,
      confirmPassword: event.confirmPassWord,
    ));
    emit(
      state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([state.name, state.email, password, state.confirmedPassword]),
      ),
    );
  }

  FutureOr<void> _onGetConfirmedPasswordChanged(GetConfirmedPasswordChanged event, Emitter<SignUpState> emit) {
    final confirmedPassword = PasswordFormzModel.dirty(PasswordParameters(
      isPasswordField: false,
      password: event.passWord,
      confirmPassword: event.confirmPassWord,
    ));
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: FormzSubmissionStatus.initial,
        isValid: Formz.validate([state.name, state.email, state.password, confirmedPassword]),
      ),
    );
  }

  FutureOr<void> _onGetAccountCreationRequested(GetAccountCreationRequested event, Emitter<SignUpState> emit) async {
    if (state.status == FormzSubmissionStatus.failure) {
      emit(state.copyWith(
        isValid: Formz.validate([state.name, state.email, state.password, state.confirmedPassword]),
      ));
    }

    if (state.status == FormzSubmissionStatus.initial || !state.isValid) {
      final name = NameFormzModel.dirty(state.name.value);
      final email = EmailFormzModel.dirty(state.email.value);
      final password = PasswordFormzModel.dirty(state.password.value);
      final confirmedPassword = PasswordFormzModel.dirty(state.confirmedPassword.value);

      emit(state.copyWith(
        name: name,
        email: email,
        password: password,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([name, email, password, confirmedPassword]),
      ));
    }

    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      SignUpDetails loginDetails = SignUpDetails(
        name: state.name.value,
        email: state.email.value,
        password: state.password.value.password,
        confirmedPassword: state.confirmedPassword.value.confirmPassword,
      );
      debugPrint('LoginDetails --> $loginDetails');
      Either<Failure, firebase_auth.UserCredential> result = await signUpUseCase(loginDetails);
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
