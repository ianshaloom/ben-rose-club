import 'package:benroseclub/core/utils/dio_client/dio_init.dart';
import 'package:get/get.dart';

import 'counter_a_controller.dart';
import 'counter_b_controller.dart';
import 'counter_c_controller.dart';

class HomeController extends GetxController {
  /// initialize the controller
  static HomeController init() => Get.put(HomeController(), permanent: true);

  /// find the controller
  static HomeController find = Get.find<HomeController>();

  /// Reactive variables
  var counterIndex = 0.obs;

  /// setter
  // -- set counter index
  void setCounterIndex(int index) {
    counterIndex.value = index;

    switch (index) {
      case 1:
        CounterBController.init();
        break;
      case 2:
        CounterCController.init();
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();

    /// initialize dio
    DioInit.init();

    /// initialize all counters controllers
    CounterAController.init();
  }
}
