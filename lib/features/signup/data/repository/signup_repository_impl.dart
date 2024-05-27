import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exception.dart';
import '../../domain/usecase/signup_usecase.dart';
import '../../../../core/network/network_info.dart';
import '../datasource/signup_remote_data_source.dart';
import '../../domain/repository/signup_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignUpRepositoryImpl implements SignUpRepository {
  final NetworkInfo networkInfo;
  final SignUpRemoteDataSource remoteDataSource;

  const SignUpRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, firebase_auth.UserCredential>> signUpUser(SignUpDetails signUpDetails) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final data = await remoteDataSource.getSignUpUser(signUpDetails);
        return Right(data);
      } on SignUpWithEmailAndPasswordFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
