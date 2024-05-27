part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

/// getName
class GetNameChanged extends SignUpEvent {
  final String name;

  const GetNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

/// getEmail
class GetEmailChanged extends SignUpEvent {
  final String email;

  const GetEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

/// getPassword
class GetPasswordChanged extends SignUpEvent {
  final String passWord;
  final String confirmPassWord;

  const GetPasswordChanged(this.passWord, this.confirmPassWord);

  @override
  List<Object> get props => [passWord, confirmPassWord];
}

/// getConfirmedPassword
class GetConfirmedPasswordChanged extends SignUpEvent {
  final String passWord;
  final String confirmPassWord;

  const GetConfirmedPasswordChanged(this.passWord, this.confirmPassWord);

  @override
  List<Object> get props => [passWord, confirmPassWord];
}

/// getAccountCreation
class GetAccountCreationRequested extends SignUpEvent {
  const GetAccountCreationRequested();

  @override
  List<Object> get props => [];
}
