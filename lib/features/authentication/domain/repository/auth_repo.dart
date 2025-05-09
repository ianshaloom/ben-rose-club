import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/success/success.dart';
import '../entity/auth_user.dart';

abstract class AuthRepository {
  AuthUser get currentUser;

  Stream<AuthUser> get user;

  Future<Either<Failure, AuthUser>> logIn(
      {required String email, required String password});

  Future<Either<Failure, AuthUser>> createUser(
      {required String username,
      required String email, required String password});
  
  Future<Either<Failure, Success>> verifyEmail();

  Future<Either<Failure, Success>> resetPassword({required String email});
  
  Future<Either<Failure, Success>> signOut();
}
