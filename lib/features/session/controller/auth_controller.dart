// lib/controllers/auth_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/device_session_service.dart';
import '../service/session_service.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _sessionService = SessionService();
  Rxn<User> firebaseUser = Rxn<User>();
  late final String _deviceId;

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, (_) => _handleAuthChanged());
    super.onInit();
  }

  Future<void> _handleAuthChanged() async {
    if (firebaseUser.value == null) return;
    _deviceId = await DeviceService.deviceId;

    final ok = await _sessionService.isCurrentDeviceActive(
      uid: firebaseUser.value!.uid,
      deviceId: _deviceId,
    );
    if (ok) {
      // bring user to home route if needed
      Get.offAllNamed('/home');
    } else {
      Get.dialog(
        const AlertDialog(
          title: Text('Device limit reached'),
          content: Text(
            'This account is already logged in on another device. '
            'Please log out there first.',
          ),
        ),
        barrierDismissible: false,
      ).then((_) async {
        await signOut();
      });
    }
  }

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    // we’re signed in → try registering this device
    final info = await DeviceService.deviceSnapshot;
    try {
      await _sessionService.registerSession(
        uid: _auth.currentUser!.uid,
        deviceId: _deviceId,
        deviceInfo: info,
      );
    } catch (e) {
      // rollback sign-in
      await signOut();
      rethrow;
    }
  }

  Future<void> signOut() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) await _sessionService.clearSession(uid);
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
