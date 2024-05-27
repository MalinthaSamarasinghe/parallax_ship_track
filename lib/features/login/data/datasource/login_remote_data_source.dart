import 'package:flutter/foundation.dart';
import '../../../../core/errors/exception.dart';
import '../../domain/usecase/password_login_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class LoginRemoteDataSource {
  Future<firebase_auth.UserCredential> getPasswordLogin(LoginDetails loginDetails);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  LoginRemoteDataSourceImpl({
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  /// Signs in with the provided [loginDetails].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<firebase_auth.UserCredential> getPasswordLogin(LoginDetails loginDetails) async {
    try {
      firebase_auth.UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: loginDetails.email,
        password: loginDetails.password,
      );
      debugPrint("UserCredential.user.displayName --> ${userCredential.user?.displayName}");
      debugPrint("UserCredential.user.email --> ${userCredential.user?.email}");
      debugPrint("UserCredential.user.emailVerified --> ${userCredential.user?.emailVerified}");
      debugPrint("UserCredential.user.isAnonymous --> ${userCredential.user?.isAnonymous}");
      debugPrint("UserCredential.user.metadata --> ${userCredential.user?.metadata}");
      debugPrint("UserCredential.user.phoneNumber --> ${userCredential.user?.phoneNumber}");
      debugPrint("UserCredential.user.photoURL --> ${userCredential.user?.photoURL}");
      debugPrint("UserCredential.user.providerData --> ${userCredential.user?.providerData}");
      debugPrint("UserCredential.user.refreshToken --> ${userCredential.user?.refreshToken}");
      debugPrint("UserCredential.user.tenantId --> ${userCredential.user?.tenantId}");
      debugPrint("UserCredential.user.uid --> ${userCredential.user?.uid}");
      debugPrint("UserCredential.credential.providerId --> ${userCredential.credential?.providerId}");
      debugPrint("UserCredential.credential.signInMethod --> ${userCredential.credential?.signInMethod}");
      debugPrint("UserCredential.credential.token --> ${userCredential.credential?.token}");
      debugPrint("UserCredential.credential.accessToken --> ${userCredential.credential?.accessToken}");
      debugPrint("UserCredential.additionalUserInfo.isNewUser --> ${userCredential.additionalUserInfo?.isNewUser}");
      debugPrint("UserCredential.additionalUserInfo.profile --> ${userCredential.additionalUserInfo?.profile}");
      debugPrint("UserCredential.additionalUserInfo.providerId --> ${userCredential.additionalUserInfo?.providerId}");
      debugPrint("UserCredential.additionalUserInfo.username --> ${userCredential.additionalUserInfo?.username}");
      debugPrint("UserCredential.additionalUserInfo.authorizationCode --> ${userCredential.additionalUserInfo?.authorizationCode}");
      return userCredential;
    } on firebase_auth.FirebaseAuthException catch (e) {
      debugPrint("LogInWithEmailAndPasswordFailure --> ${e.code}");
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }
}
