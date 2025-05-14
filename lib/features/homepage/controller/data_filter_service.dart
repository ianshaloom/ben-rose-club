import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DataFilterService extends GetxService {
  static DataFilterService get to => Get.find();

  /// Reactive variables
  final selectedDate = DateTime.now().obs;
  final dateRange = Rxn<DateTimeRange>();

  // 'today', 'weekly', 'monthly', 'range', 'yesterday', 'last7', 'last30'
  final filterType = 'today'.obs;

  bool get dateSelected => filterType.value == 'this-date';

  bool get rangeSelected => filterType.value == 'range';

  /// Initialize the service
  static DataFilterService init() {
    return Get.put(DataFilterService(), permanent: true);
  }

  /// Open date picker for single date selection
  Future<void> openDatePicker(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2025, 04, 01),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      selectedDate.value = date;
      filterType.value = 'this-date';
      dateRange.value = null;
    }
  }

  /// Open date range picker
  Future<void> openDateRangePicker(BuildContext context) async {
    final DateTimeRange? range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2025, 04, 01),
      lastDate: DateTime.now(),
      initialDateRange:
          dateRange.value ??
          DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now(),
          ),
    );

    if (range != null) {
      dateRange.value = range;
      filterType.value = 'range';
    }
  }

  /// Set filter to yesterday
  void setYesterdayFilter() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    selectedDate.value = yesterday;
    filterType.value = 'yesterday';
    dateRange.value = null;
  }

  /// Set filter to this week
  void setThisWeekFilter() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    dateRange.value = DateTimeRange(start: startOfWeek, end: now);
    filterType.value = 'this-week';
  }

  /// Set filter to last week
  void setLastWeekFilter() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday + 6));
    final endOfThatWeek = startOfWeek.add(Duration(days: 6));
    dateRange.value = DateTimeRange(start: startOfWeek, end: endOfThatWeek);
    filterType.value = 'last-week';
  }

  /// Set filter to this month
  void setThisMonthFilter() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    dateRange.value = DateTimeRange(start: startOfMonth, end: now);
    filterType.value = 'this-month';
  }

  /// Set filter to last month
  void setLastMonthFilter() {
    final now = DateTime.now();
    final startOfLastMonth = DateTime(now.year, now.month - 1, 1);
    final endOfLastMonth = DateTime(now.year, now.month, 0);
    dateRange.value = DateTimeRange(
      start: startOfLastMonth,
      end: endOfLastMonth,
    );
    filterType.value = 'last-month';
  }

  /// Get formatted date string(s) for API
  String getFormattedDateForApi() {
    switch (filterType.value) {
      case 'today':
      case 'yesterday':
      case 'this-date':
        return DateFormat('yyyy-MM-dd').format(selectedDate.value);
      case 'this-week':
      case 'last-week':
      case 'this-month':
      case 'last-month':
      case 'range':
        return '${DateFormat('yyyy-MM-dd').format(dateRange.value!.start)}'
            ' to ${DateFormat('yyyy-MM-dd').format(dateRange.value!.end)}';
      default:
        return DateFormat('yyyy-MM-dd').format(selectedDate.value);
    }
  }

  /// Get display text for current filter
  String get currentFilterText {
    switch (filterType.value) {
      case 'today':
        return 'Today: ${DateFormat('MMM d, y').format(selectedDate.value)}';
      case 'yesterday':
        return 'Yesterday: ${DateFormat('MMM d, y').format(selectedDate.value)}';
      case 'this-week':
        return 'This Week: ${DateFormat('MMM d').format(dateRange.value!.start)} - ${DateFormat('MMM d, y').format(dateRange.value!.end)}';
      case 'last-week':
        return 'Last Week: ${DateFormat('MMM d').format(dateRange.value!.start)} - ${DateFormat('MMM d, y').format(dateRange.value!.end)}';
      case 'this-month':
        return 'This Month: ${DateFormat('MMM d').format(dateRange.value!.start)} - ${DateFormat('MMM d, y').format(dateRange.value!.end)}';
      case 'last-month':
        return 'Last Month: ${DateFormat('MMM d').format(dateRange.value!.start)} - ${DateFormat('MMM d, y').format(dateRange.value!.end)}';
      case 'this-date':
        return 'On ${DateFormat('MMM d, y').format(selectedDate.value)}';
      case 'range':
        return 'Between ${DateFormat('MMM d').format(dateRange.value!.start)} - ${DateFormat('MMM d, y').format(dateRange.value!.end)}';
      default:
        return 'Today: ${DateFormat('MMM d, y').format(selectedDate.value)}';
    }
  }

  /// Generate queryparams for API
  /// Below is an example of the query parameters that can be used
  /// we will generate the query parameters based on the selected filter
  /// {
  //           'filterType': filterType,
  //           'date': date,
  //           'startDate': startDate,
  //           'endDate': endDate,
  //         },
  /// where [filterType] is the type of filter selected
  Map<String, dynamic> get queryParams {
    final params = <String, dynamic>{};

    if (filterType.value == 'this-date') {
      params['filterType'] = 'this-date';
      params['date'] = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    } else if (filterType.value == 'range') {
      params['filterType'] = 'range';
      params['startDate'] = DateFormat(
        'yyyy-MM-dd',
      ).format(dateRange.value!.start);
      params['endDate'] = DateFormat('yyyy-MM-dd').format(dateRange.value!.end);
    } else {
      params['filterType'] = filterType.value;
    }

    return params;
  }
}
