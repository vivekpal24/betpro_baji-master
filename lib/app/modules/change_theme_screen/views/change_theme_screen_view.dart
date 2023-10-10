import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/routes/app_pages.dart';

import '../../../../config/theme/my_theme.dart';
import '../controllers/change_theme_screen_controller.dart';

class ChangeThemeScreenView extends GetView<ChangeThemeScreenController> {
  ChangeThemeScreenView({Key? key}) : super(key: key);
  final logic = Get.find<ChangeThemeScreenController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => await Get.toNamed(Routes.HOME),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Change Theme'),
            leading: InkWell(
                onTap: () => Get.toNamed(Routes.HOME),
                child: const Icon(Icons.arrow_back)),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.light_mode),
                  title: const Text('Change Theme'),
                  trailing: Obx(() {
                    return Switch(
                      onChanged: (val) {
                        logic.isLight.value =val;
                        MyTheme.changeTheme();
                      },
                      value: logic.isLight.value,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
