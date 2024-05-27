import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasource/login_remote_data_source.dart';
import '../../domain/repository/login_repository.dart';
import '../../domain/usecase/password_login_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource remoteDataSource;

  const LoginRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, firebase_auth.UserCredential>> passwordLoginUser(LoginDetails loginDetails) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final data = await remoteDataSource.getPasswordLogin(loginDetails);
        return Right(data);
      } on LogInWithEmailAndPasswordFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
