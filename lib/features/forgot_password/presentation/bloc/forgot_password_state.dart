part of 'forgot_password_bloc.dart';

final class ForgotPasswordState extends Equatable {
  final FormzSubmissionStatus status;
  final EmailFormzModel email;
  final bool isValid;
  final String? successMessage;
  final String? errorMessage;

  const ForgotPasswordState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const EmailFormzModel.pure(),
    this.isValid = false,
    this.successMessage,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        status,
        email,
        isValid,
        successMessage,
        errorMessage,
      ];

  ForgotPasswordState copyWith({
    FormzSubmissionStatus? status,
    EmailFormzModel? email,
    bool? isValid,
    String? successMessage,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
