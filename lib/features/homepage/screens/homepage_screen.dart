import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import 'view/homepage_view.dart';
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
      extendBodyBehindAppBar: true,
      body: Obx(() {
        /// loading user data
        if (HomeController.find.fetchingData.value) {
          return EmptyHomepage();
        }

        /// user data not found
        if (HomeController.find.fetchFailure != null) {
          return Center(
            child: Text(
              HomeController.find.fetchFailure!.errorMessage,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          );
        }

        /// user data found
        return const HomepageView();
      }),
    );
  }
}
