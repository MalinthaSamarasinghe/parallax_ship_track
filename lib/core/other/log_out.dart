import 'dart:async';
import '../errors/exception.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class Logout {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Logout({
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  logout(BuildContext context) async {
    _applyLogoutConfigs(context).then((value) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    });
  }

  Future _applyLogoutConfigs(BuildContext context) async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]).then((value) {
        firebase_auth.FirebaseAuth.instance.currentUser?.reload();
      });
    } catch (e) {
      debugPrint('LogOutFailure: ${e.toString()}');
      throw LogOutFailure();
    }
    final storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory(),
    );

    /// Clear all preserved hydrated bloc states
    await storage.clear();
  }
}
