import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/api/benroseclub_api.dart';
import '../../../core/connection/network_info.dart';
import '../../../core/utils/failure_success/failure_n_success.dart';
import '../../../core/utils/failure_success/failures.dart';
import '../../sales/models/transaction.dart';
import '../screens/widgets/filter_bottomsheet.dart';

class CounterAController extends GetxController {
  /// initialize the controller
  static CounterAController init() =>
      Get.put(CounterAController(), permanent: true);

  /// find the controller
  static CounterAController find = Get.find<CounterAController>();

  /// Reactive variables
  var tabIndex = 0.obs;

  // -- loading
  var fetchingDataA = false.obs;

  // -- data
  var counterAData = <Map<String, dynamic>>[].obs;

  /// Success & failure
  Failure? fetchFailureA;
  Success? fetchSuccessA;

  /// fetch data
  void fetchData() async {
    try {
      // start Loading
      fetchingDataA.value = true;
      fetchFailureA = null;
      fetchSuccessA = null;

      // check internet connection
      final isConned = await NetworkInfo().isConnected();

      if (!isConned) {
        fetchFailureA = DioFailure(
          errorMessage: 'Please connect to the internet',
        );
        return;
      }

      // get data from API
      await API
          .counterA(DateFormat('yyyy-MM-dd').format(selectedDate.value))
          .then((value) {
            value.fold(
              (failure) {
                fetchFailureA = failure;
              },
              (success) {
                transactionList.assignAll(success);
                sumTransactions;
              },
            );
          });
    } catch (e) {
      fetchFailureA = DioFailure(errorMessage: e.toString());
    } finally {
      fetchingDataA.value = false;
    }
  }

  /// open date picker
  openDateicker(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2025, 04, 01),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      selectedDate.value = date;

      fetchData();
    }
  }

  /// open modal bottomsheet
  openFiltersModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const FilterBottomsheet(),
    );
  }

  /// --------------------------------------------------------------------------
  /// Reactive variables
  // get the selected date
  var selectedDate = DateTime.now().obs;

  /// Non-reactive variables
  // -- transaction list
  var transactionList = <Transaction>[].obs;

  // get sum of transactions in cash
  double cashTransaction = 0.0;
  double bankTransaction = 0.0;
  double netSales = 0.0;

  double get sumTransactions {
    cashTransaction = 0.0;
    bankTransaction = 0.0;
    netSales = 0.0;

    for (var t in transactionList) {
      cashTransaction += t.cash;
      bankTransaction += t.bank;
    }

    netSales = cashTransaction + bankTransaction;
    return cashTransaction;
  }

  //  reset all controller's values
  void reset() {
    transactionList.clear();
    cashTransaction = 0.0;
    bankTransaction = 0.0;
    netSales = 0.0;
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();

    /// init [DateFilterService]
    DateFilterService.init();
  }
}

class DateFilterService extends GetxService {
  static DateFilterService get to => Get.find();

  /// Reactive variables
  final selectedDate = DateTime.now().obs;
  final dateRange = Rxn<DateTimeRange>();
  // 'today', 'weekly', 'monthly', 'range', 'yesterday', 'last7', 'last30'
  final filterType = 'today'.obs;

  bool get dateSelected => filterType.value == 'this-date';
  bool get rangeSelected => filterType.value == 'range';

  /// Initialize the service
  static DateFilterService init() {
    return Get.put(DateFilterService(), permanent: true);
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

  /// Set filter to last 7 days
  void setLast7DaysFilter() {
    final now = DateTime.now();
    dateRange.value = DateTimeRange(
      start: now.subtract(const Duration(days: 6)), // Includes today
      end: now,
    );
    filterType.value = 'last7';
  }

  /// Set filter to last 30 days
  void setLast30DaysFilter() {
    final now = DateTime.now();
    dateRange.value = DateTimeRange(
      start: now.subtract(const Duration(days: 29)), // Includes today
      end: now,
    );
    filterType.value = 'last30';
  }

  /// Set filter to last week
  void setLastWeekFilter() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday + 6));
    final endOfThatWeek = startOfWeek.add(Duration(days: 6));
    dateRange.value = DateTimeRange(start: startOfWeek, end: endOfThatWeek);
    filterType.value = 'weekly';
  }

  /// Set filter to current month
  void setCurrentMonthFilter() {
    final now = DateTime.now();
    dateRange.value = DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: now,
    );
    filterType.value = 'monthly';
  }

  /// Get formatted date string(s) for API
  String getFormattedDateForApi() {
    switch (filterType.value) {
      case 'today':
      case 'yesterday':
      case 'this-date':
        return DateFormat('yyyy-MM-dd').format(selectedDate.value);
      case 'weekly':
      case 'monthly':
      case 'range':
      case 'last7':
      case 'last30':
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
      case 'this-date':
        return DateFormat('MMM d, y').format(selectedDate.value);
      case 'weekly':
        return 'Last Week: ${DateFormat('MMM d').format(dateRange.value!.start)} - ${DateFormat('MMM d, y').format(dateRange.value!.end)}';
      case 'monthly':
        return 'This Month: ${DateFormat('MMM d').format(dateRange.value!.start)} - ${DateFormat('MMM d, y').format(dateRange.value!.end)}';
      case 'range':
        return 'Custom: ${DateFormat('MMM d').format(dateRange.value!.start)} - ${DateFormat('MMM d, y').format(dateRange.value!.end)}';
      case 'last7':
        return 'Last 7 Days: ${DateFormat('MMM d').format(dateRange.value!.start)} - ${DateFormat('MMM d, y').format(dateRange.value!.end)}';
      case 'last30':
        return 'Last 30 Days: ${DateFormat('MMM d').format(dateRange.value!.start)} - ${DateFormat('MMM d, y').format(dateRange.value!.end)}';
      default:
        return 'Today: ${DateFormat('MMM d, y').format(selectedDate.value)}';
    }
  }
}
