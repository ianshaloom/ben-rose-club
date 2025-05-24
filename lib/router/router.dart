import 'package:go_router/go_router.dart';

import '../features/authentication/presentation/views/forgot_password_page.dart';
import '../features/authentication/presentation/views/sign_in_page.dart';
import '../features/authentication/presentation/views/sign_up_page.dart';
import '../features/zkeleton/views/zleton.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: <GoRoute>[
    GoRoute(
      path: RoutePath.root.path,
      name: RoutePath.root.name,
      builder: (context, state) => const Zleton(),
      routes: [
        GoRoute(
          path: RoutePath.signIn.path,
          name: RoutePath.signIn.name,
          builder: (context, state) => SignInPage(),
          routes: [
            GoRoute(
              path: RoutePath.forgotPassword.path,
              name: RoutePath.forgotPassword.name,
              builder: (context, state) => ForgotPasswordPage(),
            ),
          ],
        ),
        GoRoute(path: RoutePath.signUp.path, name: RoutePath.signUp.name, builder: (context, state) => SignUpPage()),
      ],
    ),
  ],
);

enum RoutePath {
  root(path: '/'),
  signIn(path: 'signin'),
  signUp(path: 'signup'),
  verifyEmail(path: 'email-verified'),
  forgotPassword(path: 'forgot-password');

  const RoutePath({required this.path});
  final String path;
}
