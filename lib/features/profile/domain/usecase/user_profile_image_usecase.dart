import 'package:dartz/dartz.dart';
import '../repository/profile_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserProfileImageUseCase implements UseCase<firebase_auth.User, String> {
  final ProfileRepository profileRepository;

  UserProfileImageUseCase({required this.profileRepository});

  @override
  Future<Either<Failure, firebase_auth.User>> call(String image) async {
    return await profileRepository.updateUserProfileImg(image);
  }
}
