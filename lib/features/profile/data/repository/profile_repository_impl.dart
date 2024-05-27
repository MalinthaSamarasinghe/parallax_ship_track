import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasource/profile_remote_data_source.dart';
import '../../domain/repository/profile_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class ProfileRepositoryImpl implements ProfileRepository {
  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource remoteDataSource;

  const ProfileRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, firebase_auth.User>> updateUserName(String name) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final data = await remoteDataSource.getUserName(name);
        return Right(data);
      } on LogInWithEmailAndPasswordFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, firebase_auth.User>> updateUserEmail(String email) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final data = await remoteDataSource.getUserEmail(email);
        return Right(data);
      } on LogInWithEmailAndPasswordFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, firebase_auth.User>> updateUserProfileImg(String profileImg) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final data = await remoteDataSource.getUserProfileImg(profileImg);
        return Right(data);
      } on LogInWithEmailAndPasswordFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
