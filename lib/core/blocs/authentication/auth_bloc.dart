import 'dart:async';
import '../event_transformer.dart';
import 'package:flutter/material.dart';
import '../../entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import '../../entities/user_info_entity.dart';
import '../../entities/user_metadata_entity.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthenticationRepository authenticationRepository;
  late final StreamSubscription<firebase_auth.User?> userSubscription;

  AuthBloc({required this.authenticationRepository}) : super(const AuthState()) {
    on<LoggedIn>(_loggedIn, transformer: Transformer.throttleDroppable());
    on<AppUserChanged>(_appUserChanged, transformer: Transformer.throttleDroppable());
    on<SessionExpired>(_sessionExpired, transformer: Transformer.throttleDroppable());
    on<AccountDeleted>(_accountDeleted, transformer: Transformer.throttleDroppable());
    userSubscription = authenticationRepository.user.listen((user) => add(AppUserChanged(user)),
      onError: (error) {
        debugPrint("Error in user stream: $error");
      },
    );
  }

  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }

  void _appUserChanged(AppUserChanged event, Emitter<AuthState> emit) {
    debugPrint("AppUserChanged user --> ${event.user}");
    debugPrint("AppUserChanged authenticationStatus --> ${event.user == null ? AuthStatus.unauthenticated : AuthStatus.authenticated}");
    emit(state.copyWith(
      authenticationStatus: event.user == null ? AuthStatus.unauthenticated : AuthStatus.authenticated,
      user: UserEntity(
        displayName: event.user?.displayName,
        email: event.user?.email,
        emailVerified: event.user?.emailVerified,
        isAnonymous: event.user?.isAnonymous,
        metadata: UserMetaDataEntity(
          creationTimestamp: event.user?.metadata.creationTime,
          lastSignInTime: event.user?.metadata.lastSignInTime,
        ),
        phoneNumber: event.user?.phoneNumber,
        photoURL: event.user?.photoURL,
        providerData: List.from((event.user?.providerData ?? []).map((data) {
          return UserInfoEntity(
            displayName: data.displayName,
            email: data.email,
            phoneNumber: data.phoneNumber,
            photoURL: data.photoURL,
            providerId: data.providerId,
            uid: data.uid,
          );
        })),
        refreshToken: event.user?.refreshToken,
        tenantId: event.user?.tenantId,
        uid: event.user?.uid,
      ),
    ));
  }

  FutureOr<void> _loggedIn(LoggedIn event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      authenticationStatus: event.authenticationStatus,
      user: UserEntity(
        displayName: event.user.displayName,
        email: event.user.email,
        emailVerified: event.user.emailVerified,
        isAnonymous: event.user.isAnonymous,
        metadata: UserMetaDataEntity(
          creationTimestamp: event.user.metadata.creationTime,
          lastSignInTime: event.user.metadata.lastSignInTime,
        ),
        phoneNumber: event.user.phoneNumber,
        photoURL: event.user.photoURL,
        providerData: List.from((event.user.providerData).map((data) {
          return UserInfoEntity(
            displayName: data.displayName,
            email: data.email,
            phoneNumber: data.phoneNumber,
            photoURL: data.photoURL,
            providerId: data.providerId,
            uid: data.uid,
          );
        })),
        refreshToken: event.user.refreshToken,
        tenantId: event.user.tenantId,
        uid: event.user.uid,
      ),
    ));
  }

  FutureOr<void> _sessionExpired(SessionExpired event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      authenticationStatus: AuthStatus.sessionExpired,
    ));
  }

  FutureOr<void> _accountDeleted(AccountDeleted event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      authenticationStatus: AuthStatus.accountDeleted,
    ));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    AuthStatus authStatus = AuthStatus.unauthenticated;

    String authStatusString = json['authenticationStatus'];
    if (authStatusString == 'AuthStatus.authenticated') {
      authStatus = AuthStatus.authenticated;
    } else if (authStatusString == 'AuthStatus.unauthenticated') {
      authStatus = AuthStatus.unauthenticated;
    } else {
      authStatus = AuthStatus.unauthenticated;
    }

    return AuthState(

      user: json["user"] == null ? null : UserEntity.fromJson(json["user"]),
      authenticationStatus: authStatus,
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return {
      'user': state.user?.toJson(),
      'authenticationStatus': state.authenticationStatus.toString(),
    };
  }
}
