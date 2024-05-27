import 'package:dartz/dartz.dart';
import '../usecase/signup_usecase.dart';
import '../../../../core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class SignUpRepository {
  Future<Either<Failure, firebase_auth.UserCredential>> signUpUser(SignUpDetails signUpDetails);
}
