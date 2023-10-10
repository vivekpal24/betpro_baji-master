// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/routes/app_pages.dart';

import '../../../../utils/default_dialogue_widget.dart';

class OtpVerificationScreenController extends GetxController {
  //TODO: Implement OtpVerificationScreenController

  RxBool isForgotPassword = false.obs;
  @override
  void onInit() {
    try{
      isForgotPassword.value = Get.arguments[0];
    }catch(e){

    }
    super.onInit();
  }


  void routingLogic(){
    isForgotPassword.value ? Get.toNamed(Routes.RESET_PASSWORD_SCREEN) :
    showCustomDialogue(
        title: 'Success!',
        description: 'Now you are registered get ready to play',
        icon: Icons.person,
        onPressed: () {
          Get.toNamed(Routes.HOME);
        },
        buttonText: 'Start Now'
    );
  }


}
