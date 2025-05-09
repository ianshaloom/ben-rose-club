/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/constants/image_path_const.dart';
import '../../../../shared/shared_ctrl.dart';
import '../../../receipt/presentation/views/donut_chart.dart';

class HomeAnalytics extends StatelessWidget {
  const HomeAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = SharedCtrl.to;

    final color = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          if (ctrl.isProcessingRequest.value) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: color.primary,
                size: 50,
              ),
            );
          }

          if (ctrl.requestFailure != null) {
            return Center(
              child: Text(ctrl.requestFailure!.errorMessage),
            );
          }

          if (ctrl.orgWeeklySales.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: SvgPicture.asset(
                  graph,
                  width: 80,
                  height: 80,
                ),
              ),
            );
          }

          return AnimatedPieChart(
            stokeWidth: 18.0,
            padding: 5,
            animatedSpeed: 900,
            pieRadius: constraints.maxWidth / 5,
            segments: ctrl.buildPieChartData(),
          );
        });
      },
    );
  }
}
*/
