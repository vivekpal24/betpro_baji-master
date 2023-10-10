import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../config/theme/my_styles.dart';
import '../../../../config/theme/my_theme.dart';
import '../controllers/otp_verification_screen_controller.dart';

class OtpVerificationScreenView extends GetView<OtpVerificationScreenController> {
  OtpVerificationScreenView({Key? key}) : super(key: key);
  final logic = Get.find<OtpVerificationScreenController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                ),
                color: MyStyles.getContainerColor(isLightTheme: MyTheme().getThemeIsLight),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: CircleAvatar(
                      backgroundColor: MyStyles.getSecondaryColor(isLightTheme: MyTheme().getThemeIsLight),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Verification',
                    style: MyStyles
                        .getTextTheme(isLightTheme: MyTheme().getThemeIsLight)
                        .headlineSmall,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'We’ve the code send to your email address: example@example.com',
                    style: MyStyles
                        .getTextTheme(isLightTheme: MyTheme().getThemeIsLight)
                        .titleMedium,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Pinput(
                    length: 6,
                    defaultPinTheme: PinTheme(
                        width: 50.sp,
                        height: 60.sp,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.transparent),
                            color: MyStyles.getSecondaryColor(isLightTheme: MyTheme().getThemeIsLight)
                        )
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(child: Text('00:56', style: MyStyles
                      .getTextTheme(isLightTheme: MyTheme().getThemeIsLight)
                      .titleLarge,)),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Didn’t receive code? ',
                        style: MyStyles
                            .getTextTheme(isLightTheme: MyTheme().getThemeIsLight)
                            .bodySmall,
                      ),
                      Text(
                        'Resend Code',
                        style: MyStyles
                            .getTextTheme(isLightTheme: MyTheme().getThemeIsLight)
                            .bodySmall!
                            .copyWith(color: MyStyles.getPrimaryColor(isLightTheme: MyTheme().getThemeIsLight)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      logic.routingLogic();
                    },
                    style: MyStyles
                        .getElevatedButtonTheme(isLightTheme: MyTheme().getThemeIsLight)
                        .style
                        ?.copyWith(
                      textStyle: MyStyles.getElevatedButtonTextStyle(MyTheme().getThemeIsLight, isBold: false, fontSize: 16.sp),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Continue'),
                      ],
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
