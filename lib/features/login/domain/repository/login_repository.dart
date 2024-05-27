import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../usecase/password_login_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class LoginRepository {
  Future<Either<Failure, firebase_auth.UserCredential>> passwordLoginUser(LoginDetails loginDetails);
}
