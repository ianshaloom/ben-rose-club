// lib/services/session_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class SessionService {
  final _db = FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _userDoc(String uid) {
    if (uid.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }
    return _db.collection('users').doc(uid);
  }

  Future<void> registerSession({
    required String uid,
    required String deviceId,
    required Map<String, dynamic> deviceInfo,
  }) async {
    if (uid.isEmpty || deviceId.isEmpty) {
      throw ArgumentError('User ID and Device ID cannot be empty');
    }

    final userRef = _userDoc(uid);
    await _db.runTransaction((tx) async {
      final snap = await tx.get(userRef);
      final current = snap.data()?['activeDeviceId'] as String?;

      // If no active device, or the current device matches, set the new session
      // Otherwise, throw an error indicating another device is already active
      if (current == null || current == deviceId) {
        tx.set(userRef, {'activeDeviceId': deviceId}, SetOptions(merge: true));
        tx.set(userRef.collection('sessions').doc(deviceId), {
          'deviceInfo': deviceInfo,
          'lastActive': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      } else {
        throw Exception('Another device is already active');
      }
    });
  }

  Future<bool> isCurrentDeviceActive({required String uid, required String deviceId}) async {
    final userSnap = await _userDoc(uid).get();
    return deviceId == userSnap.data()?['activeDeviceId'];
  }

  Future<void> clearSession(String uid) async {
    await _userDoc(uid).update({'activeDeviceId': FieldValue.delete()});
  }
}
