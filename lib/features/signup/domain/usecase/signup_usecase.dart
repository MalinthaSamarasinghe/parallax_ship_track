import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repository/signup_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignUpUseCase implements UseCase<firebase_auth.UserCredential, SignUpDetails> {
  final SignUpRepository signUpRepository;

  SignUpUseCase({required this.signUpRepository});

  @override
  Future<Either<Failure, firebase_auth.UserCredential>> call(SignUpDetails signUpDetails) async {
    return await signUpRepository.signUpUser(signUpDetails);
  }
}

class SignUpDetails extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmedPassword;

  const SignUpDetails({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmedPassword,
  });

  @override
  List<Object?> get props => [name, email, password, confirmedPassword];
}
