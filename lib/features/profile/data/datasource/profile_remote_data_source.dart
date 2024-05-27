import 'package:flutter/foundation.dart';
import '../../../../core/errors/exception.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class ProfileRemoteDataSource {
  Future<firebase_auth.User> getUserName(String name);
  Future<firebase_auth.User> getUserEmail(String email);
  Future<firebase_auth.User> getUserProfileImg(String profileImg);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  ProfileRemoteDataSourceImpl({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  /// Updates with the provided [name].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<firebase_auth.User> getUserName(String name) async {
    try {
      await _firebaseAuth.currentUser?.updateDisplayName(name);
      return _firebaseAuth.currentUser!;
    } on firebase_auth.FirebaseAuthException catch (e) {
      debugPrint("LogInWithEmailAndPasswordFailure --> ${e.code}");
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  /// Updates with the provided [email].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<firebase_auth.User> getUserEmail(String email) async {
    try {
      /// Ensure the user is recently signed in before updating the email
      await _firebaseAuth.currentUser?.verifyBeforeUpdateEmail(email);
      /// The email update is initiated, and the user needs to verify the new email address
      /// You might want to inform the user to check their new email for a verification link
      /// Return the current user (the email on the user object might not be updated until the new email is verified)
      return _firebaseAuth.currentUser!;
    } on firebase_auth.FirebaseAuthException catch (e) {
      debugPrint("LogInWithEmailAndPasswordFailure --> ${e.code}");
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  /// Updates with the provided [profileImg].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<firebase_auth.User> getUserProfileImg(String profileImg) async {
    try {
      await _firebaseAuth.currentUser?.updatePhotoURL(profileImg);
      return _firebaseAuth.currentUser!;
    } on firebase_auth.FirebaseAuthException catch (e) {
      debugPrint("LogInWithEmailAndPasswordFailure --> ${e.code}");
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }
}
