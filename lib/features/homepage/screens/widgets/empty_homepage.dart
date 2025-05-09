import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/image_path_const.dart';

class EmptyHomepage extends StatelessWidget {
  const EmptyHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    final baseColor = color.primary.withAlpha(10);
    final highlightColor = Colors.grey.withAlpha(30);
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
                child: Column(
                  children: [
                    // pie chart shimmer effect
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 35,
                        left: 35,
                        right: 35,
                        bottom: 10,
                      ),
                      child: Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),

                    // org switch buttons shimmer effect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              height: 25,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              height: 25,
                              width: 70,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              height: 25,
                              width: 70,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // List view shimmer effect
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: color.surfaceBright,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(40),
                              bottom: Radius.circular(30)),
                          // top box shadow
                          boxShadow: [
                            BoxShadow(
                              color: color.primary.withAlpha(13),
                              offset: const Offset(0, -5),
                              blurRadius: 10,
                            ),
                          ],
                        ),

                        // list view shimmer effect
                        child: Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 120,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: color.surface,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const EmptyNavigationBar(),
      ],
    );
  }
}


class EmptyNavigationBar extends StatelessWidget {
  const EmptyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(2, pieChartLinear, 'pie-chart', context),
          _navItem(3, dailyReviewLinear, 'daily-review', context),
        ],
      ),
    );
  }

  Widget _navItem(
      int index,
      String icon,
      String label,
      BuildContext context,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SvgPicture.asset(
        icon,
        height: 30,
        colorFilter: ColorFilter.mode(
          Colors.grey,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
