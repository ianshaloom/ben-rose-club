import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../authentication/domain/entity/auth_user.dart';
import '../../authentication/presentation/controller/authrepo_controller.dart';
import '../../authentication/presentation/views/landingpage.dart';
import '../../authentication/presentation/views/verify_email_page.dart';
import '../../homepage/controller/home_controller.dart';
import '../../homepage/screens/homepage_screen.dart';

class Zleton extends StatelessWidget {
  const Zleton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthRepoController>();

    return Obx(
      () =>
          controller.emailVerified.value
              ? StreamBuilder(
                stream: controller.user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final user = snapshot.data;
                    final isUserEmpty = user != AuthUser.empty;
                    final isEmailVerified = user!.isEmailVerified;

                    if (isUserEmpty) {
                      if (isEmailVerified) {
                        HomeController.init();
                        return const HomepageScreen();
                      } else {
                        AuthRepoController.find.verifyEmail();
                        return const VerifyEmailPage();
                      }
                    } else {
                      return const LandingPage();
                    }
                  } else {
                    return const Scaffold(
                      body: Center(
                        child: SizedBox(
                          height: 75,
                          width: 75,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                },
              )
              : StreamBuilder(
                stream: controller.user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final user = snapshot.data;
                    final isUserEmpty = user != AuthUser.empty;
                    final isEmailVerified = user!.isEmailVerified;

                    if (isUserEmpty) {
                      if (isEmailVerified) {
                        HomeController.init();
                        return const HomepageScreen();
                      } else {
                        AuthRepoController.find.verifyEmail();
                        return const VerifyEmailPage();
                      }
                    } else {
                      return const LandingPage();
                    }
                  } else {
                    return const Scaffold(
                      body: Center(
                        child: SizedBox(
                          height: 75,
                          width: 75,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                },
              ),
    );
  }
}

/*   Widget build(BuildContext context) {
    final controller = Get.find<AuthRepoController>();

    final user = controller.currentUser;
    final isUserEmpty = user == AuthUser.empty;
    final isEmailVerified = user.isEmailVerified;

    if (isUserEmpty) {
      return const LandingPage();
    } else if (!isUserEmpty && !isEmailVerified) {
      return const VerifyEmailPage();
    } else {
      return const HomePage();
    }
  } */
