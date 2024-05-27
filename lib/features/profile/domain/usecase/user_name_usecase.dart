import 'package:dartz/dartz.dart';
import '../repository/profile_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserNameUseCase implements UseCase<firebase_auth.User, String> {
  final ProfileRepository profileRepository;

  UserNameUseCase({required this.profileRepository});

  @override
  Future<Either<Failure, firebase_auth.User>> call(String name) async {
    return await profileRepository.updateUserName(name);
  }
}
