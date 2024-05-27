part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppUserChanged extends AuthEvent {
  final firebase_auth.User? user;

  const AppUserChanged(this.user);

  @override
  List<Object?> get props => [user];
}

class LoggedIn extends AuthEvent {
  final firebase_auth.User user;
  final AuthStatus authenticationStatus;

  const LoggedIn({
    required this.user,
    required this.authenticationStatus,
  });

  @override
  List<Object?> get props => [user, authenticationStatus];
}

class SessionExpired extends AuthEvent {
  const SessionExpired();

  @override
  List<Object?> get props => [];
}

class AccountDeleted extends AuthEvent {
  const AccountDeleted();

  @override
  List<Object?> get props => [];
}
