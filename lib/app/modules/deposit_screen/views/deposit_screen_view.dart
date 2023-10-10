import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/utils/custom_textfield_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../config/theme/my_styles.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../components/custom_loading_overlay.dart';
import '../../../components/my_widgets_animator.dart';
import '../controllers/deposit_screen_controller.dart';

class DepositScreenView extends GetView<DepositScreenController> {
  const DepositScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositScreenController>(builder: (logic) {
      return MyWidgetsAnimator(
          apiCallStatus: logic.apiCallStatus,
          loadingWidget: () {
            return Scaffold(
              body: Center(child: getLoadingIndicator(msg: 'Loading Data')),
            );
          },
          errorWidget: () {
            return Scaffold(
              body: Center(child: getLoadingIndicator(msg: 'Please Try Again')),
            );
          },
          successWidget: () {
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              child: CircleAvatar(
                                backgroundColor: MyStyles.getSecondaryColor(isLightTheme: MyTheme().getThemeIsLight),
                                radius: 20.0,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: MyStyles.getIconTheme(isLightTheme: MyTheme().getThemeIsLight).color,
                                ),
                              ),
                            ),
                            Text(
                              'Deposit',
                              style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).titleLarge,
                            ),
                            CircleAvatar(
                              backgroundColor: MyStyles.getSecondaryColor(isLightTheme: MyTheme().getThemeIsLight),
                              radius: 20.0,
                              child: Icon(
                                Icons.search,
                                color: MyStyles.getIconTheme(isLightTheme: MyTheme().getThemeIsLight).color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(color: MyStyles.getContainerColor(isLightTheme: MyTheme().getThemeIsLight), borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Payment Method',
                              style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).titleLarge,
                            ),
                            const Divider(),
                            GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: logic.gateways.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20.0, crossAxisSpacing: 10.0,childAspectRatio: 1.5),
                                itemBuilder: (_, i) {
                                  return Obx(() => InkWell(
                                    onTap: (){
                                      logic.selectedIndex.value = i;
                                    },
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [

                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: MyStyles.getSecondaryColor(isLightTheme: MyTheme().getThemeIsLight),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Image.network(logic.gateways[i].imageUrl ?? ""),
                                        ),
                                        Visibility(child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Icon(Icons.check_circle),
                                        ),visible: logic.selectedIndex.value == i,),
                                      ],
                                    ),
                                  ));
                                })
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.only(left: 20.0,right: 20.0),
                        decoration: BoxDecoration(color: MyStyles.getContainerColor(isLightTheme: MyTheme().getThemeIsLight), borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Amount To Deposit',
                              style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).titleLarge,
                            ),
                            const Divider(),
                            const SizedBox(height: 10.0,),
                            CustomTextFieldWidget(labelText: 'Enter Amount', hintText: 'Enter Deposit Amount', textEditingController: logic.amountController, textFieldType: TextFieldType.PHONE)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Expanded(child: ElevatedButton(onPressed: (){
                              if(logic.selectedIndex.value == 1){
                                logic.handleStripePayment();
                              }else{
                                logic.handlePaypalPayment();
                              }

                            }, child: const Text('Continue'))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    });

  }
}
