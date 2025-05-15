import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/api/benroseclub_api.dart';
import '../../../core/connection/network_info.dart';
import '../../../core/utils/failure_success/failure_n_success.dart';
import '../../../core/utils/failure_success/failures.dart';
import '../../sales/models/transaction.dart';
import '../screens/widgets/filter_bottomsheet.dart';
import 'data_filter_service.dart';

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
          .counterA(queryParameters: DataFilterService.to.queryParams)
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
      // just add the amount to the netSales
      netSales += t.amount;

      // check if transaction payvia is empty
      if (t.payViaEmpty) {
        continue;
      }
      // check if transaction is cash
      if (t.isCash) {
        cashTransaction += t.cash;
      }
      // check if transaction is bank
      if (t.isBank) {
        bankTransaction += t.bank;
      }
    }

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
    DataFilterService.init();
  }
}
