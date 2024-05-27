import 'package:flutter/foundation.dart';
import '../../../../core/errors/exception.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class ForgotPasswordRemoteDataSource {
  Future<String> getForgotPasswordLink(String email);
}

class ForgotPasswordRemoteDataSourceImpl implements ForgotPasswordRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  ForgotPasswordRemoteDataSourceImpl({
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  /// Password Resets in with the provided [email].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<String> getForgotPasswordLink(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return 'Password reset link sent to $email. Please check your $email to reset your password.';
    } on firebase_auth.FirebaseAuthException catch (e) {
      debugPrint("LogInWithEmailAndPasswordFailure --> ${e.code}");
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }
}
