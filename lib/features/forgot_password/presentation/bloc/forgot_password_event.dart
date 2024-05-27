part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

/// getEmail
class ForgotEmailRequested extends ForgotPasswordEvent {
  final String email;

  const ForgotEmailRequested(this.email);

  @override
  List<Object> get props => [email];
}

/// getForgotPasswordLink
class ForgotPasswordLinkRequested extends ForgotPasswordEvent {
  const ForgotPasswordLinkRequested();

  @override
  List<Object> get props => [];
}
