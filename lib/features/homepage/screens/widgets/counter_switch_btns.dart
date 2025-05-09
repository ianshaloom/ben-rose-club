import 'package:benroseclub/features/homepage/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OrganisationButtons extends StatelessWidget {
  const OrganisationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = HomeController.find;

    final color = Theme.of(context).colorScheme;
    final color1 = color.inverseSurface;
    final color2 = color.primary.withAlpha(77);
    final font = Theme.of(context).textTheme.bodyMedium;

    final font1 = font!.copyWith(
      fontWeight: FontWeight.w700,
      color: color1,
    );

    final font2 = font.copyWith(
      fontWeight: FontWeight.w700,
      color: color2,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 15),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            GestureDetector(
              onTap: () => ctrl.setCounterIndex(0),
              child: Text(
                'Counter A',
                style: ctrl.counterIndex.value == 0 ? font1 : font2,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => ctrl.setCounterIndex(1),
              child: Text(
                'Counter B',
                style: ctrl.counterIndex.value == 1 ? font1 : font2,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => ctrl.setCounterIndex(2),
              child: Text(
                'Counter C',
                style: ctrl.counterIndex.value == 2 ? font1 : font2,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
