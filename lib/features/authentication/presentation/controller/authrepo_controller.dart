import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../session/service/device_session_service.dart';
import '../../../session/service/session_service.dart';
import '../../core/errors/failures.dart';
import '../../data/provider/network/authentication_ds.dart';
import '../../data/repository/auth_repo_impl.dart';
import '../../domain/entity/auth_user.dart';
import '../../domain/usecase/auth_usecase.dart';

// 🔽 NEW imports

class AuthRepoController extends GetxController {
  /* ──────────────────── existing code ──────────────────── */

  static AuthRepoController init() =>
      Get.put(AuthRepoController(AuthUC(AuthRepoImpl(FirebaseAuthentification()))), permanent: true);

  static AuthRepoController get find => Get.find<AuthRepoController>();

  final AuthUC authUC;

  AuthRepoController(this.authUC);

  /* … all your existing reactive fields … */
  var isLoggingIn = false.obs;
  var isSigningUp = false.obs;
  var isResettingPassword = false.obs;
  var isLoggingOut = false.obs;

  AuthUser get currentUser => authUC.currentUser;

  Stream<AuthUser> get user => authUC.user;

  var loggedInUser = <AuthUser>[].obs;
  var loggedInFailure = <Failure>[].obs;
  var createdUser = <AuthUser>[].obs;
  var createdUserFailure = <Failure>[].obs;
  var resetLinkSent = false.obs;
  var resetLinkFailure = <Failure>[].obs;
  var emailVerified = false.obs;
  var isVerifyingEmail = false.obs;
  var emailVerificationFailure = <Failure>[].obs;

  /* ──────────────────── new session fields ──────────────────── */

  final SessionService _sessionService = SessionService();
  String? _deviceId;
  StreamSubscription<AuthUser>? _userSub;
  var sessionAllowed = true.obs;

  /* ──────────────────── lifecycle hook ──────────────────── */

  @override
  void onInit() {
    super.onInit();

    // Whenever AuthUC’s user stream emits, verify that this device is allowed.
    _userSub = authUC.user.listen(_handleUserChanged);
  }

  @override
  void onClose() {
    _userSub?.cancel();
    super.onClose();
  }

  /* ──────────────────── public methods (unchanged signatures) ──────────────────── */

  Future<void> logIn({required String email, required String password}) async {
    isLoggingIn.value = true;

    final userOrFailure = await authUC.logIn(email: email, password: password);

    await userOrFailure.fold((failure) async => loggedInFailure.add(failure), (user) async {
      final ok = await _tryRegisterCurrentDevice(uid: user.id);
      if (ok) {
        loggedInUser.add(user);

        // handle session state
        sessionAllowed.value = ok;
      }
    });

    isLoggingIn.value = false;
  }

  Future<void> createUser({required String username, required String email, required String password}) async {
    isSigningUp.value = true;

    final userOrFailure = await authUC.createUser(username: username, email: email, password: password);

    userOrFailure.fold((failure) => createdUserFailure.add(failure), (user) async {
      final ok = await _tryRegisterCurrentDevice(uid: user.id);
      if (ok) createdUser.add(user);
    });

    isSigningUp.value = false;
  }

  Future<void> sendPasswordResetLink({required String email}) async {
    isResettingPassword(false);

    final successOrFailure = await authUC.resetPassword(email: email);
    successOrFailure.fold((failure) => resetLinkFailure.add(failure), (_) => resetLinkSent(true));
  }

  Future<void> verifyEmail() async {
    isVerifyingEmail.value = true;
    final successOrFailure = await authUC.verifyEmail();
    successOrFailure.fold((failure) => emailVerificationFailure.add(failure), (_) {});
    isVerifyingEmail.value = false;
  }

  Future<void> signOut() async {
    // 💡 Clear the server-side “activeDeviceId” before logging out
    final uid = currentUser.uidOrNull;
    if (uid != null) {
      await _sessionService.clearSession(uid);
    }

    final successOrFailure = await authUC.signOut();
    successOrFailure.fold((_) {}, (_) => isLoggingOut(false));
  }

  /* ──────────────────── private helpers ──────────────────── */

  /// Called every time the auth stream changes.
  Future<void> _handleUserChanged(AuthUser user) async {
    try {
      _deviceId ??= await DeviceService.deviceId;
      final allowed = await _sessionService.isCurrentDeviceActive(uid: user.id, deviceId: _deviceId!);

      if (!allowed) {
        // This device is not allowed to use this account
        sessionAllowed(false);
      }
    } catch (e) {
      debugPrint('Error checking session: $e');
    }
  }

  /// Registers this handset as the *only* active device.
  /// Returns true if successful, false otherwise.
  Future<bool> _tryRegisterCurrentDevice({required String uid}) async {
    _deviceId ??= await DeviceService.deviceId;
    final deviceInfo = await DeviceService.deviceSnapshot;

    try {
      await _sessionService.registerSession(uid: uid, deviceId: _deviceId!, deviceInfo: deviceInfo);
      return true;
    } on Exception catch (e) {
      // Convert to your domain-level Failure and surface it
      loggedInFailure.add(
        AuthFailure(errorMessage: e.toString()), // use whichever Failure ctor you have
      );
      // Roll back login state
      await authUC.signOut();
      return false;
    }
  }
}

/* ──────────────────── tiny extensions to reduce null noise ──────────────────── */
extension on AuthUser {
  String? get uidOrNull => (id.isEmpty) ? null : id;
}
