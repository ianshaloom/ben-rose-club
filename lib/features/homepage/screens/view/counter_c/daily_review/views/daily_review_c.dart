import 'package:flutter/material.dart';

import '../../../../../../../core/constants/image_path_const.dart';
import '../../../../../../../core/constants/sizes.dart';
import '../../../../../controller/counter_c_controller.dart';
import '../widgets/grid_card.dart';
import '../widgets/transaction_tile.dart';

class DailyReviewC extends StatelessWidget {
  const DailyReviewC({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final s = CounterCController.find;

    return RefreshIndicator(
      onRefresh: () async => s.fetchData(),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            centerTitle: true,
            toolbarHeight: 180,
            floating: true,
            title: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              height: 180,
              child: Column(
                children: [
                  // -- row one
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                          child: GridCard(
                            svgPath: bank,
                            title: 'Bank',
                            amount: s.bankTransaction,
                            bgColor: const Color.fromARGB(197, 197, 221, 243),
                            titleColor: const Color(0xff0057CD),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Expanded(
                          child: GridCard(
                            svgPath: cash,
                            title: 'Cash',
                            amount: s.cashTransaction,
                            bgColor: const Color.fromARGB(197, 197, 221, 243),
                            titleColor: const Color(0xff0057CD),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // -- row two, with one grid card filling the rest of the space
                  SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GridCard(
                            svgPath: netSales,
                            title: 'Total Sales',
                            amount: s.netSales,
                            bgColor: const Color(0xff0057CD),
                            titleColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 30),
            sliver: SliverList.builder(
              itemCount: s.transactionList.length,
              itemBuilder: (context, index) {
                final transaction = s.transactionList[index];

                return TransactionTile(transaction: transaction);
              },
            ),
          ),
        ],
      ),
    );
  }
}
