import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/response/login_response_model.dart';
import 'package:getx_skeleton/app/modules/dashboard_screen/controllers/dashboard_screen_controller.dart';
import 'package:getx_skeleton/app/routes/app_pages.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../services/base_client.dart';
import '../../category_screen/controllers/category_screen_controller.dart';
import '../../my_bet_screen/controllers/my_bet_screen_controller.dart';
import '../../news_screen/controllers/news_screen_controller.dart';
import '../../profile_screen/controllers/profile_screen_controller.dart';

class LoginScreenController extends GetxController {
  //TODO: Implement LoginScreenController

  final count = 0.obs;
  RxBool isAccepted = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  login() async {
    var data = {"email": emailController.text, "password": passwordController.text};
    await BaseClient.safeApiCall(
      Constants.logInApiUrl, // url
      RequestType.post,
      data: data, // request type (get,post,delete,put)
      onLoading: () {
        isLoading.value = true;
      },
      onSuccess: (response) async {
        // api done successfully
        isLoading.value = false;
        await MySharedPref.setData(LoginResponseModel.fromJson(response.data).token ?? '', 'token');

        Get.put(DashboardScreenController());
        Get.put(CategoryScreenController());
        Get.put(MyBetScreenController());
        Get.put(NewsScreenController());
        Get.put(ProfileScreenController());
        Get.toNamed(Routes.HOME);
      },
      // if you don't pass this method base client
      // will automaticly handle error and show message to user
      onError: (error) {
        isLoading.value = false;

        // show error message to user
        CustomSnackBar.showCustomErrorToast(message: LoginResponseModel.fromJson(jsonDecode(jsonEncode(error.response!.data))).message ?? '');
      },
    );
  }

  bool validate() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty && passwordController.text.length > 7) {
      return true;
    } else {
      if (emailController.text.isEmptyOrNull) {
        CustomSnackBar.showCustomErrorToast(message: 'Email Is Required');
      } else if (passwordController.text.isEmptyOrNull) {
        CustomSnackBar.showCustomErrorToast(message: 'Password Is Required');
      } else if (passwordController.text.length < 8) {
        CustomSnackBar.showCustomErrorToast(message: 'Password must be at least 8 character');
      }
      return false;
    }
  }
}
