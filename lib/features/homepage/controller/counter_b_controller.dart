import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/api/benroseclub_api.dart';
import '../../../core/connection/network_info.dart';
import '../../../core/utils/failure_success/failure_n_success.dart';
import '../../../core/utils/failure_success/failures.dart';
import '../../sales/models/transaction.dart';
import 'data_filter_service.dart';

class CounterBController extends GetxController {
  /// initialize the controller
  static CounterBController init() =>
      Get.put(CounterBController(), permanent: true);

  /// find the controller
  static CounterBController find = Get.find<CounterBController>();

  /// Reactive variables
  var tabIndex = 0.obs;

  // -- loading
  var fetchingDataB = false.obs;

  // -- data
  var counterBData = <Map<String, dynamic>>[].obs;

  /// Success & failure
  Failure? fetchFailureB;
  Success? fetchSuccessB;

  /// fetch data
  void fetchData() async {
    try {
      // start Loading
      fetchingDataB.value = true;
      fetchFailureB = null;
      fetchSuccessB = null;

      // check internet connection
      final isConned = await NetworkInfo().isConnected();

      if (!isConned) {
        fetchFailureB = DioFailure(
          errorMessage: 'Please connect to the internet',
        );
        return;
      }

      // get data from API
      await API
          .counterB(queryParameters: DataFilterService.to.queryParams)
          .then((value) {
            value.fold(
              (failure) {
                fetchFailureB = failure;
              },
              (success) {
                transactionList.assignAll(success);
                sumTransactions;
              },
            );
          });
    } catch (e) {
      fetchFailureB = DioFailure(errorMessage: e.toString());
    } finally {
      fetchingDataB.value = false;
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
  }
}
