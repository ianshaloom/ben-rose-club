/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../router/route_names.dart';
import '../../../../shared/shared_ctrl.dart';
import '../../../../theme/text_scheme.dart';
import '../../../receipt/presentation/views/donut_chart.dart';
import '../widgets/recent_orders_list.dart';

class HomeListViews extends StatelessWidget {
  const HomeListViews({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final sctrl = SharedCtrl.to;
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: color.surfaceBright,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(40), bottom: Radius.circular(30)),
          // top box shadow
          boxShadow: [
            BoxShadow(
              color: color.primary.withAlpha(13),
              offset: const Offset(0, -5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            _handle(context),
            _listBtns(context),
            Expanded(
              // child: RecentOrders(),
              child: Obx(() {
                final index = sctrl.lsIndex.value;

                if (index == 0) {
                  return const RecentOrders();
                }

                if (sctrl.isProcessingRequest.value) {
                  return _shimmerGridView(context);
                }

                if (sctrl.orgWeeklySales.isEmpty) {
                  return Center(
                    child: Text(
                      'No sales data available',
                      style: bodyMedium(textTheme).copyWith(
                        color: color.onSurface,
                      ),
                    ),
                  );
                }

                return Stack(
                  children: [
                    GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 120,
                        childAspectRatio: 0.5,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: sctrl.orgWeeklySales.length,
                      itemBuilder: (context, index) {
                        final pie = sctrl.orgWeeklySales[index];

                        return WeekTile(
                          onClick: () =>
                              sctrl.dayReceipts(context, pie.receipts),
                          dailySale: pie,
                        );
                      },
                    ),
                    if (sctrl.orgIndex.value == 0)
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: FloatingActionButton(
                          backgroundColor: isDark ? Colors.white : Colors.black,
                          shape: const CircleBorder(),
                          onPressed: () {},
                          child: Text(
                            NumberFormat('00')
                                .format(sctrl.totalWatWeeklySales),
                            style: bodyRegular(textTheme).copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: color.surface,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _handle(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      height: 4,
      width: 50,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: color.primary.withAlpha(51),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _listBtns(BuildContext context) {
    final sctrl = SharedCtrl.to;

    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final color1 = color.inverseSurface;
    final color2 = color.primary.withAlpha(77);
    final font = bodyBold(textTheme).copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w700,
    );
    final font1 = font.copyWith(
      color: color1,
    );

    final font2 = font.copyWith(
      color: color2,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 15),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            InkWell(
              onTap: () => onPressed(0),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Orders',
                  style: sctrl.lsIndex.value == 0 ? font1 : font2,
                ),
              ),
            ),
            Text(' | ', style: bodyBold(textTheme)),
            InkWell(
              onTap: () => onPressed(1),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Sales',
                  style: sctrl.lsIndex.value == 1 ? font1 : font2,
                ),
              ),
            ),
            const Spacer(),
            sctrl.lsIndex.value == 0
                ? InkWell(
                    onTap: () {
                      context.go(AppNamedRoutes.toTransHistory);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'View All',
                        style: bodyRegular(textTheme),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  void onPressed(int i) {
    final sctrl = SharedCtrl.to;

    sctrl.toLsIndex(i);
  }

  Widget _shimmerGridView(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        mainAxisExtent: 120,
        childAspectRatio: 0.5,
        crossAxisSpacing: 10,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: color.primary.withAlpha(26),
          highlightColor: color.primary.withAlpha(51),
          child: Container(
            decoration: BoxDecoration(
              color: color.surface,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
*/
