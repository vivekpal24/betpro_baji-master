import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/components/custom_loading_overlay.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../config/images/image_locations.dart';
import '../../../../config/theme/my_styles.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../../utils/custom_textfield_widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_screen_controller.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  final logic = Get.find<LoginScreenController>();

LoginScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
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
                            'Welcome back',
                            style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).headlineSmall,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Let’s us know what your name, email, and your password',
                            style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).titleMedium,
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
                          CustomTextFieldWidget(
                            labelText: 'Email Address',
                            hintText: 'Enter your email address',
                            textEditingController: logic.emailController,
                            textFieldType: TextFieldType.EMAIL,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomTextFieldWidget(
                            labelText: 'Password',
                            hintText: 'Enter new password',
                            textEditingController: logic.passwordController,
                            textFieldType: TextFieldType.PASSWORD,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: logic.isAccepted.value,
                                        onChanged: (bool? val) {
                                          logic.isAccepted(val!);
                                        }),
                                    Text(
                                      'Remember me',
                                      style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodySmall,
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () => Get.toNamed(Routes.FORGET_PASSWORD_SCREEN),
                                    child: Text('Forgot password',style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodyMedium!.copyWith(color: MyStyles.getPrimaryColor(isLightTheme: MyTheme().getThemeIsLight),),)).visible(false),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if(logic.validate()){
                                logic.login();
                              }
                            },
                            style: MyStyles.getElevatedButtonTheme(isLightTheme: MyTheme().getThemeIsLight).style?.copyWith(
                              textStyle: MyStyles.getElevatedButtonTextStyle(MyTheme().getThemeIsLight, isBold: false, fontSize: 16.sp),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Sign In'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Expanded(
                                child: Divider(
                                  thickness: 1.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.0,right: 4.0),
                                child: Text('or Sign in with'),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Center(child: Image(image: AssetImage(ImageLocations.socialLogin,),width: 130.sp,height: 35.sp,)),

                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account? ',
                        style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodySmall,
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(Routes.REGISTRATION_SCREEN),
                        child: Text(
                          'Sign Up',
                          style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodySmall!.copyWith(color: MyStyles.getPrimaryColor(isLightTheme: MyTheme().getThemeIsLight)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Obx(() => logic.isLoading.value ? Center(child: getLoadingIndicator(msg: 'Logging In')) : Container())
        ],
      ),
    );
  }
}
