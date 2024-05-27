import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repository/login_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class PasswordLoginUseCase implements UseCase<firebase_auth.UserCredential, LoginDetails> {
  final LoginRepository loginRepository;

  PasswordLoginUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, firebase_auth.UserCredential>> call(LoginDetails loginDetails) async {
    return await loginRepository.passwordLoginUser(loginDetails);
  }
}

class LoginDetails extends Equatable {
  final String email;
  final String password;

  const LoginDetails({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
