import 'package:flutter/material.dart';

import '../../../../../../core/constants/image_path_const.dart';
import '../../../controller/daily_review/daily_review_controller.dart';
import '../widgets/grid_card.dart';
import '../widgets/transaction_tile.dart';

class DailyReview extends StatelessWidget {
  const DailyReview({super.key});

  @override
  Widget build(BuildContext context) {    
    //
    final s = DailyReviewController.find;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          centerTitle: true,
          toolbarHeight: 270,
          floating: true,
          title: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            height: 270,
            child: GridView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
                mainAxisExtent: 80,
              ),
              children: [
                GridCard(
                  svgPath: bank,
                  title: 'Bank',
                  amount: s.bankTransaction,
                  bgColor: const Color.fromARGB(197, 197, 221, 243),
                  titleColor: const Color(0xff0057CD),
                ),
                GridCard(
                  svgPath: cash,
                  title: 'Cash',
                  amount: s.cashTransaction,
                  bgColor: const Color.fromARGB(197, 197, 221, 243),
                  titleColor: const Color(0xff0057CD),
                ),
                GridCard(
                  svgPath: netSales,
                  title: 'Total Sales',
                  amount: s.netSales,
                  bgColor: const Color(0xff0057CD),
                  titleColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(left: 3, right: 3, top: 10),
          sliver: SliverList.builder(
            itemCount: s.transactionList.length,
            itemBuilder: (context, index) {
              final transaction = s.transactionList[index];

              return TransactionTile(
                transaction: transaction,
              );
            },
          ),
        ),
      ],
    );
  }
}
