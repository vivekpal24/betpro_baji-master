import 'package:get/get.dart';

import '../controllers/bet_details_screen_controller.dart';

class BetDetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BetDetailsScreenController>(
      () => BetDetailsScreenController(),
    );
  }
}
