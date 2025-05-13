/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../core/constants/image_path_const.dart';
import '../../controller/home_controller.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key,});

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
    final hctrl = HomeController.find;

    return Obx(
          () => GestureDetector(
        onTap: () {
          // hctrl.setTabIndex(index);

          if (index == 0) {
          }

          if (index == 1) {
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: hctrl.tabIndex.value == index
                ? Colors.white.withAlpha(51)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            icon,
            height: 30,
            colorFilter: ColorFilter.mode(
              hctrl.tabIndex.value == index ? Colors.white : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}*/
