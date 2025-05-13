import 'package:benroseclub/core/constants/sizes.dart';
import 'package:benroseclub/core/widgets/custom_filled_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/image_path_const.dart';
import '../../../../core/utils/utility_methods.dart';
import '../../../../theme/text_scheme.dart';
import '../../controller/counter_a_controller.dart';

class FilterBottomsheet extends StatelessWidget {
  const FilterBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return // In your view file
    Column(
      children: [
        // Display current filter
        Obx(
          () =>
              DateFilterService.to.dateSelected ||
                      DateFilterService.to.rangeSelected
                  ? const SizedBox()
                  : Text(
                    DateFilterService.to.currentFilterText,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
        ),

        const SizedBox(height: 16),

        // Quick filter buttons
        Obx(() {
          return Column(
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  // Today button
                  ChoiceChip(
                    label: const Text('Today'),
                    selected: DateFilterService.to.filterType.value == 'daily',
                    onSelected: (selected) {
                      if (selected) {
                        DateFilterService.to.selectedDate.value =
                            DateTime.now();
                        DateFilterService.to.filterType.value = 'daily';
                        DateFilterService.to.dateRange.value = null;
                      }
                    },
                  ),

                  // Yesterday button
                  ChoiceChip(
                    label: const Text('Yesterday'),
                    selected:
                        DateFilterService.to.filterType.value == 'yesterday',
                    onSelected: (selected) {
                      if (selected) {
                        DateFilterService.to.selectedDate.value = DateTime.now()
                            .subtract(const Duration(days: 1));
                        DateFilterService.to.filterType.value = 'yesterday';
                        DateFilterService.to.dateRange.value = null;
                      }
                    },
                  ),

                  // Last 7 Days button
                  ChoiceChip(
                    label: const Text('Last 7 Days'),
                    selected: DateFilterService.to.filterType.value == 'last7',
                    onSelected: (selected) {
                      if (selected) {
                        DateFilterService.to.setLast7DaysFilter();
                      }
                    },
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  // Last 30 Days button
                  ChoiceChip(
                    label: const Text('Last 30 Days'),
                    selected: DateFilterService.to.filterType.value == 'last30',
                    onSelected: (selected) {
                      if (selected) {
                        DateFilterService.to.setLast30DaysFilter();
                      }
                    },
                  ),

                  // Last Week button
                  ChoiceChip(
                    label: const Text('Last Week'),
                    selected: DateFilterService.to.filterType.value == 'weekly',
                    onSelected: (selected) {
                      if (selected) {
                        DateFilterService.to.setLastWeekFilter();
                      }
                    },
                  ),

                  // This Month button
                  ChoiceChip(
                    label: const Text('This Month'),
                    selected:
                        DateFilterService.to.filterType.value == 'monthly',
                    onSelected: (selected) {
                      if (selected) {
                        DateFilterService.to.setCurrentMonthFilter();
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        }),
        const Divider(),

        // Custom Date button
        Column(
          children: [
            CalendaTile(title: 'Date'),
            const SizedBox(height: 10),
            CalendaTile(title: 'Date Range'),
          ],
        ),

        /*// Custom Date button
        CustomFilledBtn(
          onPressed: () {
            DateFilterService.to.openDatePicker(context);
            DateFilterService.to.filterType.value = 'daily';
            DateFilterService.to.dateRange.value = null;
          },
          title: 'Select Date',
          pad: 10,
        ),
        Row(
          children: [
            const Divider(),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'or',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 10),
            const Divider(),
          ],
        ),

        // Custom Range button

        CustomFilledBtn(
          onPressed: () {
            DateFilterService.to.openDateRangePicker(context);
            // DateFilterService.to.filterType.value = 'range';
            // DateFilterService.to.dateRange.value = null;
          },
          title: 'Select Date Range',
          pad: 10,
        ),*/
        const Spacer(),

        // Close button
        CustomFilledBtn(
          onPressed: () => CounterAController.find.fetchData(),
          title: 'Apply Filter',
          pad: 10,
        ),
      ],
    );
  }
}

class CalendaTile extends StatelessWidget {
  final String title;
  const CalendaTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;
    final color = Theme.of(context).colorScheme.onSurface;

    return InkWell(
      onTap: () {
        _showDatePicker(context);
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          children: [
            brightness == Brightness.dark
                ? SvgPicture.asset(calendar, height: 30)
                : SvgPicture.asset(calendarDark, height: 30),
            const SizedBox(width: 7),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: bodyDefaultBold(textTheme)),
                _buildDate(title, context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDate(String title, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme.onSurface;

    if (title == 'Date') {
      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: color.withAlpha(127)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () =>
              DateFilterService.to.dateSelected
                  ? Text(
                    DateFilterService.to.currentFilterText,
                    style: bodyDefault(textTheme).copyWith(color: color),
                  )
                  : Text(
                    "Choose a Date",
                    style: bodyDefault(
                      textTheme,
                    ).copyWith(color: color.withAlpha(127)),
                  ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: color.withAlpha(127)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () =>
              DateFilterService.to.rangeSelected
                  ? Text(
                    DateFilterService.to.currentFilterText,
                    style: bodyDefault(textTheme).copyWith(color: color),
                  )
                  : Text(
                    "Select Date Range",
                    style: bodyDefault(
                      textTheme,
                    ).copyWith(color: color.withAlpha(127)),
                  ),
        ),
      );
    }
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      if (title == 'Start Date') {
        // p.startDate.assign(date);

        // clear the other date filters
        // _clearDateFilters(p);
      } else {
        // p.endDate.assign(date);

        // clear the other date filters
        // _clearDateFilters(p);
      }
    }
  }

  /*  void _clearDateFilters(IntercessFilterCtrl p) {
    p.todaysChecked.value = false;
    p.yesterdayChecked.value = false;
    p.last7DaysChecked.value = false;
    p.last30DaysChecked.value = false;
  }*/
}
