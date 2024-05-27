import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'core/network/network_info.dart';
import 'core/blocs/authentication/auth_bloc.dart';
import 'core/repositories/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/interceptors/authorization_interceptor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';

import 'features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import 'features/forgot_password/domain/usecase/forgot_password_usecase.dart';
import 'features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'features/forgot_password/data/repository/forgot_password_repository_impl.dart';
import 'features/forgot_password/data/datasource/forgot_password_remote_data_source.dart';

import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/login/domain/repository/login_repository.dart';
import 'features/login/domain/usecase/password_login_usecase.dart';
import 'features/login/data/repository/login_repository_impl.dart';
import 'features/login/data/datasource/login_remote_data_source.dart';

import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/profile/domain/usecase/user_name_usecase.dart';
import 'features/profile/domain/usecase/user_email_usecase.dart';
import 'features/profile/domain/repository/profile_repository.dart';
import 'features/profile/data/repository/profile_repository_impl.dart';
import 'features/profile/domain/usecase/user_profile_image_usecase.dart';
import 'features/profile/data/datasource/profile_remote_data_source.dart';

import 'features/signup/domain/usecase/signup_usecase.dart';
import 'features/signup/presentation/bloc/sign_up_bloc.dart';
import 'features/signup/domain/repository/signup_repository.dart';
import 'features/signup/data/repository/signup_repository_impl.dart';
import 'features/signup/data/datasource/signup_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> setupLocators() async {
  /// Feature: authentication
  // Blocs
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(authenticationRepository: sl()));
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository());

  /// Feature: Login Screen
  // Blocs
  sl.registerFactory<LoginBloc>(() => LoginBloc(passwordLoginUser: sl()));
  // Use Cases
  sl.registerLazySingleton<PasswordLoginUseCase>(() => PasswordLoginUseCase(loginRepository: sl()));
  // Repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl());

  /// Feature: SignUp Screen
  // Blocs
  sl.registerFactory<SignUpBloc>(() => SignUpBloc(signUpUseCase: sl()));
  // Use Cases
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(signUpRepository: sl()));
  // Repositories
  sl.registerLazySingleton<SignUpRepository>(() => SignUpRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<SignUpRemoteDataSource>(() => SignUpRemoteDataSourceImpl());

  /// Feature: Profile Screen
  // Blocs
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(userNameUseCase: sl(), userEmailUseCase: sl(), userProfileImageUseCase: sl()));
  // Use Cases
  sl.registerLazySingleton<UserEmailUseCase>(() => UserEmailUseCase(profileRepository: sl()));
  sl.registerLazySingleton<UserNameUseCase>(() => UserNameUseCase(profileRepository: sl()));
  sl.registerLazySingleton<UserProfileImageUseCase>(() => UserProfileImageUseCase(profileRepository: sl()));
  // Repositories
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl());

  /// Feature: Forgot Password Screen
  // Blocs
  sl.registerFactory<ForgotPasswordBloc>(() => ForgotPasswordBloc(forgotPasswordUseCase: sl()));
  // Use Cases
  sl.registerLazySingleton<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(forgotPasswordRepository: sl()));
  // Repositories
  sl.registerLazySingleton<ForgotPasswordRepository>(() => ForgotPasswordRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<ForgotPasswordRemoteDataSource>(() => ForgotPasswordRemoteDataSourceImpl());

  /// Feature: Dashboard Screen
  // Blocs
  sl.registerFactory<DashboardBloc>(() => DashboardBloc());

  /// Network
  sl.registerFactory<Dio>(() => Dio());
  sl.registerFactory<DioClient>(() => DioClient(public: sl<Dio>(), auth: sl<Dio>()..interceptors.add(sl<AuthorizationInterceptor>())));
  sl.registerFactory<AuthorizationInterceptor>(() => AuthorizationInterceptor(authBloc: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());

  /// Plugins
  /// Shared Preferences
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPref);
}
