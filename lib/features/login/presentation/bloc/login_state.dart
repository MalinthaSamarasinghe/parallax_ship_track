part of 'login_bloc.dart';

enum LoginStatus {
  unknown,
  loginInitial,
  loginInProgress,
}

final class LoginState extends Equatable {
  final LoginStatus loginStatus;
  final EmailFormzModel email;
  final CommonFormzModel password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final firebase_auth.UserCredential? userCredential;
  final String? errorMessage;

  const LoginState({
    this.loginStatus = LoginStatus.unknown,
    this.email = const EmailFormzModel.pure(),
    this.password = const CommonFormzModel.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.userCredential,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        loginStatus,
        email,
        password,
        status,
        isValid,
        userCredential,
        errorMessage,
      ];

  LoginState copyWith({
    LoginStatus? loginStatus,
    EmailFormzModel? email,
    CommonFormzModel? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    firebase_auth.UserCredential? userCredential,
    String? errorMessage,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      userCredential: userCredential ?? this.userCredential,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
