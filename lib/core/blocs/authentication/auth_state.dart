part of 'auth_bloc.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  sessionExpired,
  accountDeleted,
}

class AuthState extends Equatable {
  final UserEntity? user;
  final AuthStatus authenticationStatus;

  const AuthState({
    this.user,
    this.authenticationStatus = AuthStatus.unauthenticated,
  });

  @override
  List<Object?> get props => [user, authenticationStatus];

  AuthState copyWith({
    UserEntity? user,
    AuthStatus? authenticationStatus,
  }) {
    return AuthState(
      user: user ?? this.user,
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
    );
  }
}
