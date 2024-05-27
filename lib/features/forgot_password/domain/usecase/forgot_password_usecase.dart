import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repository/forgot_password_repository.dart';

class ForgotPasswordUseCase implements UseCase<String, String> {
  final ForgotPasswordRepository forgotPasswordRepository;

  ForgotPasswordUseCase({required this.forgotPasswordRepository});

  @override
  Future<Either<Failure, String>> call(String email) async {
    return await forgotPasswordRepository.getForgotPassword(email);
  }
}
