import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/datasources/database/isar_init.dart';
import 'features/authentication/presentation/controller/authrepo_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // database
  await IsarService.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (_) async {
      // Initialize Authentication Repository
      AuthRepoController.init();
    },
  );

  runApp(const BenRoseClub());
}
