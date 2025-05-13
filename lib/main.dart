import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'features/authentication/presentation/controller/authrepo_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((_) async {
    // Initialize Authentication Repository
    AuthRepoController.init();
  });

  runApp(const BenRoseClub());
}
