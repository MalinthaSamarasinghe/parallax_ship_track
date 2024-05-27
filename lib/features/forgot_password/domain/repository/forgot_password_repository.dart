import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, String>> getForgotPassword(String email);
}
