import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/constants/image_path_const.dart';
import '../../../../../../../core/utils/utility_methods.dart';
import '../../../../../../sales/models/transaction.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final font = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Text(
                elapsedTime(transaction.sdate, transaction.stime),
                style: font.bodyMedium!.copyWith(
                  color: color.onSurface.withAlpha(77),
                  fontSize: 11,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 10,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(3),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_2_rounded,
                      size: 15,
                      color: color.primary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      transaction.user,
                      style: font.bodyMedium!.copyWith(
                        color: color.onSurface.withAlpha(77),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 70,
              // color: Colors.black26,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: color.onSurface.withAlpha(18),
                    width: 0.5,
                  ),
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(197, 197, 221, 243),
                  radius: 30,
                  child: SvgPicture.asset(moneyIn, height: 43),
                ),
                title: Text(
                  '# ${transaction.rcno} ~ ${transaction.payvia.toUpperCase()}',
                  style: font.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color.onSurface,
                  ),
                ),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'KES ',
                      style: font.bodyMedium!.copyWith(fontSize: 10),
                    ),
                    Text(
                      NumberFormat(
                        '#,##0.00',
                        'en_US',
                      ).format(transaction.amount),
                      style: font.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: color.onSurface.withAlpha(179),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
