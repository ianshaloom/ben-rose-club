import 'package:get/get.dart';

import '../../../models/transaction.dart';

class DailyReviewController extends GetxController {

  /// initialize the controller
  static DailyReviewController init() => Get.put(DailyReviewController(),);

  /// find the controller
  static DailyReviewController find = Get.find<DailyReviewController>();


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
      if (t.isCash) {
        cashTransaction += t.cash;
      }

      if (t.isBank) {
        bankTransaction += t.bank;
      }
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

}