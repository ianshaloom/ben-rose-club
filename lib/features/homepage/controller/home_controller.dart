import 'package:get/get.dart';

import '../../../core/utils/failure_success/failure_n_success.dart';
import '../../../core/utils/failure_success/failures.dart';
import '../../../core/utils/failure_success/success.dart';

class HomeController extends GetxController {
  /// initialize the controller
  static HomeController init() => Get.put(HomeController(), permanent: true);

  /// find the controller
  static HomeController find = Get.find<HomeController>();

  /// Reactive variables
  var tabIndex = 0.obs;
  var counterIndex = 0.obs;
 var fetchingData = false.obs;


 /// Success & failure
  Failure? fetchFailure;
  Success? fetchSuccess;

  /// getters



  /// setters
  // -- set tab index
  void setTabIndex(int index) {
    tabIndex.value = index;
  }

  // -- set counter index
  void setCounterIndex(int index) {
    counterIndex.value = index;
  }


  /// fetch data
  void fetchData() async {
    try {
      // start Loading
      fetchingData.value = true;
      fetchFailure = null;
      fetchSuccess = null;

      // Simulate a network request
      await Future.delayed(const Duration(seconds: 2));

      // Simulate success
      fetchSuccess = DioSuccess(successContent: 'Data fetched successfully');
    } catch (e) {
      fetchFailure = DioFailure(errorMessage: e.toString());
    } finally {
      fetchingData.value = false;
    }
  }

}