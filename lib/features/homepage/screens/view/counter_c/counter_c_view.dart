import 'package:flutter/material.dart';

import 'daily_review/views/daily_review_c.dart';

class CounterCView extends StatelessWidget {
  const CounterCView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DailyReviewC();
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
      transitionBuilder:
          (child, animation) =>
              FadeTransition(opacity: animation, child: child),
      child: children[index],
    );
  }
}
