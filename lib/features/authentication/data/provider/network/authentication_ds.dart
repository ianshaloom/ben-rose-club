import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../../core/errors/exception.dart';
import '../../../domain/entity/auth_user.dart';
import '../database/crud/user_crud.dart';

class FirebaseAuthentification {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final UserCrud userCrud = UserCrud();

  AuthUser get currentUser {
    final user = firebase_auth.FirebaseAuth.instance.currentUser;

    if (user != null) {
      user.reload();
      return AuthUser.fromFirebase(user);
    }

    return AuthUser.empty;
  }

  Stream<AuthUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser != null) {
        firebaseUser.reload();
        return AuthUser.fromFirebase(firebaseUser);
      } else {
        return AuthUser.empty;
      }
    });
  }

  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final firebase_auth.UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user == null) {
        throw Exception('Sign in failed: The user is null after sign in.');
      }

      return AuthUser.fromFirebase(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(message: e.code);
    } catch (e) {
      throw AuthenticationException(message: e.toString());
    }
  }

  Future<AuthUser> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final firebase_auth.UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user == null) {
        throw Exception('Sign up failed: The user is null after sign up.');
      }

      return AuthUser.fromFirebase(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(message: e.code);
    } catch (e) {
      throw AuthenticationException(message: e.toString());
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      final firebase_auth.User? user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception(
          'Failed to send email verification, User cannot be null',
        );
      }
      await user.sendEmailVerification();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(message: e.code);
    } catch (e) {
      throw AuthenticationException(message: e.toString());
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(message: e.code);
    } catch (e) {
      throw AuthenticationException(message: e.toString());
    }
  }

  Future<AuthUser> changePassword({required String password}) async {
    try {
      final firebase_auth.User? user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('Failed to change password, User was found to be null');
      }
      await user.updatePassword(password);

      /// ToDo

      return AuthUser.fromFirebase(user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(message: e.code);
    } catch (e) {
      throw AuthenticationException(message: e.toString());
    }
  }

  Future<void> deleteAccount() async {
    try {
      final firebase_auth.User? user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.delete();

        // delete user info from device
        final localUser = await userCrud.getUserById(1);
        await userCrud.deleteUser(localUser!);
      } else {
        throw Exception("Delete Account: The user can't be null.");
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(message: e.code);
    } catch (e) {
      throw AuthenticationException(message: e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();

      // delete user info from device
      final localUser = await userCrud.getUserById(1);
      await userCrud.deleteUser(localUser!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthenticationException(message: e.code);
    } catch (e) {
      throw AuthenticationException(message: e.toString());
    }
  }

  // factory constructor
  FirebaseAuthentification._({
    required firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  static final FirebaseAuthentification _instance = FirebaseAuthentification._(
    firebaseAuth: firebase_auth.FirebaseAuth.instance,
  );
  factory FirebaseAuthentification() => _instance;
}
