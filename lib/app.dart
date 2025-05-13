import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'router/router.dart';

class BenRoseClub extends StatelessWidget {
  const BenRoseClub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
