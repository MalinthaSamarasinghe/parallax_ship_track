part of 'sign_up_bloc.dart';

final class SignUpState extends Equatable {
  final NameFormzModel name;
  final EmailFormzModel email;
  final PasswordFormzModel password;
  final PasswordFormzModel confirmedPassword;
  final FormzSubmissionStatus status;
  final bool isValid;
  final firebase_auth.UserCredential? userCredential;
  final String? errorMessage;

  const SignUpState({
    this.name = const NameFormzModel.pure(),
    this.email = const EmailFormzModel.pure(),
    this.password = const PasswordFormzModel.pure(PasswordParameters(isPasswordField: true, password: '', confirmPassword: '')),
    this.confirmedPassword = const PasswordFormzModel.pure(PasswordParameters(isPasswordField: false, password: '', confirmPassword: '')),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.userCredential,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        confirmedPassword,
        status,
        isValid,
        userCredential,
        errorMessage,
      ];

  SignUpState copyWith({
    NameFormzModel? name,
    EmailFormzModel? email,
    PasswordFormzModel? password,
    PasswordFormzModel? confirmedPassword,
    FormzSubmissionStatus? status,
    bool? isValid,
    firebase_auth.UserCredential? userCredential,
    String? errorMessage,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      userCredential: userCredential ?? this.userCredential,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
