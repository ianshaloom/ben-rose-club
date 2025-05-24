import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/image_path_const.dart';
import '../../authentication/presentation/controller/authrepo_controller.dart';
import '../../session/session_view.dart';
import '../controller/counter_a_controller.dart';
import '../controller/counter_b_controller.dart';
import '../controller/counter_c_controller.dart';
import '../controller/home_controller.dart';
import 'view/counter_a/counter_a_view.dart';
import 'view/counter_b/counter_b_view.dart';
import 'view/counter_c/counter_c_view.dart';
import 'widgets/counter_switch_btns.dart';
import 'widgets/empty_homepage.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: color.surface,
        title: const OrganisationButtons(),
        centerTitle: true,
      ),
      body: Obx(() {
        if (!AuthRepoController.find.sessionAllowed.value) {
          return const SessionView();
        }

        return AnimatedPageSwitcher(
          index: HomeController.find.counterIndex.value,
          children: const [CounterA(), CounterB(), CounterC()],
        );
      }),
    );
  }
}

class AnimatedPageSwitcher extends StatelessWidget {
  const AnimatedPageSwitcher({super.key, required this.index, required this.children});

  final int index;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 0),
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: children[index],
    );
  }
}

class CounterA extends StatelessWidget {
  const CounterA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        /// loading user data
        if (CounterAController.find.fetchingDataA.value) {
          return EmptyHomepage();
        }

        /// user data not found
        if (CounterAController.find.fetchFailureA != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// -- server error image illustration
                  SvgPicture.asset(serverError, height: 200, width: 200),
                  const SizedBox(height: 30),

                  /// -- server error message
                  Text(
                    CounterAController.find.fetchFailureA!.errorMessage,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  /// -- retry button
                  TextButton(
                    onPressed: () {
                      CounterAController.find.fetchData();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        /// user data found
        return const CounterAView();
      }),

      /// date floating button
      floatingActionButton: FloatingActionButton(
        onPressed: () => CounterAController.find.openFiltersModalSheet(context),
        child: SvgPicture.asset(
          calendarDark,
          height: 35,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class CounterB extends StatelessWidget {
  const CounterB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        /// loading user data
        if (CounterBController.find.fetchingDataB.value) {
          return EmptyHomepage();
        }

        /// user data not found
        if (CounterBController.find.fetchFailureB != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// -- server error image illustration
                  SvgPicture.asset(serverError, height: 200, width: 200),
                  const SizedBox(height: 30),

                  /// -- server error message
                  Text(
                    CounterBController.find.fetchFailureB!.errorMessage,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  /// -- retry button
                  TextButton(
                    onPressed: () {
                      CounterBController.find.fetchData();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        /// user data found
        return const CounterBView();
      }),

      /// date floating button
      floatingActionButton: FloatingActionButton(
        onPressed: () => CounterAController.find.openFiltersModalSheet(context),
        child: SvgPicture.asset(
          calendarDark,
          height: 35,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class CounterC extends StatelessWidget {
  const CounterC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        /// loading user data
        if (CounterCController.find.fetchingDataC.value) {
          return EmptyHomepage();
        }

        /// user data not found
        if (CounterCController.find.fetchFailureC != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// -- server error image illustration
                  SvgPicture.asset(serverError, height: 200, width: 200),
                  const SizedBox(height: 30),

                  /// -- server error message
                  Text(
                    CounterCController.find.fetchFailureC!.errorMessage,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  /// -- retry button
                  TextButton(
                    onPressed: () {
                      CounterCController.find.fetchData();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        /// user data found
        return const CounterCView();
      }),

      /// date floating button
      floatingActionButton: FloatingActionButton(
        onPressed: () => CounterAController.find.openFiltersModalSheet(context),
        child: SvgPicture.asset(
          calendarDark,
          height: 35,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
        ),
      ),
    );
  }
}
