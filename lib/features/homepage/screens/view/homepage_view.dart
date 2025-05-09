import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../sales/presentation/views/daily_review/daily_review.dart';
import '../../../sales/presentation/views/pie_view/pie_view.dart';
import '../../controller/home_controller.dart';
import '../widgets/custom_navigation_bar.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: color.surface,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                ),
                child: Obx(
                      () => Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: AnimatedPageSwitcher(
                      index: HomeController.find.tabIndex.value,
                      children: const [
                        PieView(),
                        DailyReview(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // bottom navigation bar
        const CustomNavigationBar(),
      ],
    );
  }
}

class AnimatedPageSwitcher extends StatelessWidget {
  const AnimatedPageSwitcher({
    super.key,
    required this.index,
    required this.children,
  });

  final int index;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 0),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: children[index],
    );
  }
}

