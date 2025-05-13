import 'package:benroseclub/core/widgets/custom_filled_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/image_path_const.dart';
import '../../../../theme/text_scheme.dart';
import '../../controller/counter_a_controller.dart';
import '../../controller/counter_b_controller.dart';
import '../../controller/counter_c_controller.dart';
import '../../controller/data_filter_service.dart';

class FilterBottomsheet extends StatelessWidget {
  const FilterBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return // In your view file
    Column(
      children: [
        /* // Display current filter
        Obx(
          () =>
              DataFilterService.to.dateSelected ||
                      DataFilterService.to.rangeSelected
                  ? const SizedBox()
                  : Text(
                    DataFilterService.to.currentFilterText,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
        ),

        const SizedBox(height: 16),*/

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
                    selected: DataFilterService.to.filterType.value == 'today',
                    onSelected: (selected) {
                      if (selected) {
                        DataFilterService.to.selectedDate.value =
                            DateTime.now();
                        DataFilterService.to.filterType.value = 'today';
                        DataFilterService.to.dateRange.value = null;
                      }
                    },
                  ),

                  // Yesterday button
                  ChoiceChip(
                    label: const Text('Yesterday'),
                    selected:
                        DataFilterService.to.filterType.value == 'yesterday',
                    onSelected: (selected) {
                      if (selected) {
                        DataFilterService.to.selectedDate.value = DateTime.now()
                            .subtract(const Duration(days: 1));
                        DataFilterService.to.filterType.value = 'yesterday';
                        DataFilterService.to.dateRange.value = null;
                      }
                    },
                  ),

                  // Last Week button
                  ChoiceChip(
                    label: const Text('This Week'),
                    selected:
                        DataFilterService.to.filterType.value == 'this-week',
                    onSelected: (selected) {
                      if (selected) {
                        DataFilterService.to.setThisWeekFilter();
                      }
                    },
                  ),
                ],
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  // Last 7 Days button
                  ChoiceChip(
                    label: const Text('Last Week'),
                    selected:
                        DataFilterService.to.filterType.value == 'last-week',
                    onSelected: (selected) {
                      if (selected) {
                        DataFilterService.to.setLastWeekFilter();
                      }
                    },
                  ),

                  // This Month button
                  ChoiceChip(
                    label: const Text('This Month'),
                    selected:
                        DataFilterService.to.filterType.value == 'this-month',
                    onSelected: (selected) {
                      if (selected) {
                        DataFilterService.to.setThisMonthFilter();
                      }
                    },
                  ),

                  // Last 30 Days button
                  ChoiceChip(
                    label: const Text('Last Month'),
                    selected:
                        DataFilterService.to.filterType.value == 'last-month',
                    onSelected: (selected) {
                      if (selected) {
                        DataFilterService.to.setLastMonthFilter();
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
            const SizedBox(height: 10),
            CalendaTile(title: 'Date Range'),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
        const Spacer(),

        // Close button
        CustomFilledBtn(
          onPressed: () {
            // close the bottom sheet
            Navigator.of(context).pop();

            // Call the API with the selected date
            CounterAController.find.fetchData();

            // check if [CounterBController] and [CounterCController] are
            // initialized
            if (Get.isRegistered<CounterBController>()) {
              CounterBController.find.fetchData();
            }

            if (Get.isRegistered<CounterCController>()) {
              CounterCController.find.fetchData();
            }

            // elese initialize them
            CounterBController.init();
            CounterCController.init();
          },
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
    final brightness = Theme.of(context).brightness;

    return InkWell(
      onTap: () {
        if (title == 'Date') {
          DataFilterService.to.openDatePicker(context);
        } else {
          // Show date range picker
          DataFilterService.to.openDateRangePicker(context);
        }
      },
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Row(
          children: [
            brightness == Brightness.dark
                ? SvgPicture.asset(calendar, height: 30)
                : SvgPicture.asset(calendarDark, height: 30),
            const SizedBox(width: 7),
            Expanded(child: _buildDate(title, context)),
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
        alignment: Alignment.centerLeft,
        height: 50,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: color.withAlpha(127)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () =>
              DataFilterService.to.dateSelected
                  ? Text(
                    DataFilterService.to.currentFilterText,
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
        alignment: Alignment.centerLeft,
        height: 50,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: color.withAlpha(127)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () =>
              DataFilterService.to.rangeSelected
                  ? Text(
                    DataFilterService.to.currentFilterText,
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
