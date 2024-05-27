part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  final LoginStatus loginStatus;

  const LoginEvent({
    required this.loginStatus,
  });

  @override
  List<Object> get props => [loginStatus];
}

/// getEmail
class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged(this.email) : super(loginStatus: LoginStatus.unknown);

  @override
  List<Object> get props => [email];
}

/// getPassword
class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged(this.password)
      : super(loginStatus: LoginStatus.unknown);

  @override
  List<Object> get props => [password];
}

/// getPasswordUserLogin
class PasswordLoginRequested extends LoginEvent {
  const PasswordLoginRequested({required super.loginStatus});

  @override
  List<Object> get props => [];
}
