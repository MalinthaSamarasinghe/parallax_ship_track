import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class ProfileRepository {
  Future<Either<Failure, firebase_auth.User>> updateUserName(String name);
  Future<Either<Failure, firebase_auth.User>> updateUserEmail(String email);
  Future<Either<Failure, firebase_auth.User>> updateUserProfileImg(String profileImg);
}
