import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/constants/image_path_const.dart';
import '../../../../../../theme/text_scheme.dart';

class GridCard extends StatelessWidget {
  final String svgPath;
  final String title;
  final double amount;
  final Color bgColor;
  final Color titleColor;

  const GridCard({
    super.key,
    required this.svgPath,
    required this.title,
    required this.amount,
    required this.bgColor,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bgColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              title == 'Mpesa' ? Image.asset(
                      mpesaLogo,
                      height: 35,
                      width: 40,
                    )
                  :
              SvgPicture.asset(
                svgPath,
                height: 30,
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: bodyDefault(textTheme).copyWith(
                  fontSize: 12,
                  color: titleColor,
                ),
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
          Text(
            NumberFormat('#,##0.00').format(amount),
            style: bodyLarge(textTheme).copyWith(
              fontSize: 16,
              color: titleColor,
            ),
          ),
        ],
      ),
    );
  }
}
