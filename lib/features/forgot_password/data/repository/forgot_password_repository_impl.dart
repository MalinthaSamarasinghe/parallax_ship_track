import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasource/forgot_password_remote_data_source.dart';
import '../../domain/repository/forgot_password_repository.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final NetworkInfo networkInfo;
  final ForgotPasswordRemoteDataSource remoteDataSource;

  const ForgotPasswordRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, String>> getForgotPassword(String email) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final data = await remoteDataSource.getForgotPasswordLink(email);
        return Right(data);
      } on LogInWithEmailAndPasswordFailure catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
