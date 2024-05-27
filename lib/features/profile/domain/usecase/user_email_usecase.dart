import 'package:dartz/dartz.dart';
import '../repository/profile_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserEmailUseCase implements UseCase<firebase_auth.User, String> {
  final ProfileRepository profileRepository;

  UserEmailUseCase({required this.profileRepository});

  @override
  Future<Either<Failure, firebase_auth.User>> call(String email) async {
    return await profileRepository.updateUserEmail(email);
  }
}
