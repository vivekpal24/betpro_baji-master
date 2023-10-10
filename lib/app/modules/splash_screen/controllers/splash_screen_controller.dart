import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../data/local/my_shared_pref.dart';
import '../../category_screen/controllers/category_screen_controller.dart';
import '../../dashboard_screen/controllers/dashboard_screen_controller.dart';
import '../../my_bet_screen/controllers/my_bet_screen_controller.dart';
import '../../news_screen/controllers/news_screen_controller.dart';
import '../../profile_screen/controllers/profile_screen_controller.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    if (kDebugMode) {
      print('Init');
    }
    navigateToOnboard();
    super.onInit();
  }

  Future<void> navigateToOnboard() async {
    String token = MySharedPref.getData('token') ?? '';

    await Future.delayed(const Duration(seconds: 2)).then((value) {
      if (token.isEmptyOrNull) {
        Get.offAndToNamed(Routes.ONBOARD_SCREEN);
      } else {
        Get.put(DashboardScreenController());
        Get.put(CategoryScreenController());
        Get.put(MyBetScreenController());
        Get.put(NewsScreenController());
        Get.put(ProfileScreenController());
        Get.toNamed(Routes.HOME);
      }
    });
  }
}
