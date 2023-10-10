import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/components/my_widgets_animator.dart';

import '../../../../config/theme/my_styles.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../../utils/bet_card_widget.dart';
import '../../../components/custom_loading_overlay.dart';
import '../controllers/dashboard_screen_controller.dart';

class DashboardScreenView extends GetView<DashboardScreenController> {
  const DashboardScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardScreenController>(builder: (logic) {
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
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
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
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: MyStyles.getSecondaryColor(isLightTheme: MyTheme().getThemeIsLight),
                                    radius: 30.0,
                                    backgroundImage: NetworkImage(logic.profile.user?.imageUrl ?? ''),
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hello, ${logic.profile.user?.name}',
                                        style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).titleLarge,
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 10.0, right: 2.0, top: 2.0, bottom: 2.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          border: Border.all(color: Colors.white.withOpacity(0.5)),
                                          color: Colors.white.withOpacity(0.1),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              '\$${logic.profile.user?.balance}',
                                              style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodyMedium,
                                            ),
                                            const SizedBox(
                                              width: 6.0,
                                            ),
                                            Icon(Icons.monetization_on, color: MyStyles.getPrimaryColor(isLightTheme: MyTheme().getThemeIsLight)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: MyStyles.getSecondaryColor(isLightTheme: MyTheme().getThemeIsLight),
                                    radius: 20.0,
                                    child: Icon(
                                      Icons.search,
                                      color: MyStyles.getIconTheme(isLightTheme: MyTheme().getThemeIsLight).color,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: MyStyles.getSecondaryColor(isLightTheme: MyTheme().getThemeIsLight),
                                    radius: 20.0,
                                    child: Icon(
                                      Icons.notifications_active,
                                      color: MyStyles.getIconTheme(isLightTheme: MyTheme().getThemeIsLight).color,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200.0,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(20.0),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: logic.data.slider?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: Image.network(
                                        logic.data.slider?[index].imageUrl ?? '',
                                        height: 150.0,
                                        width: Get.width / 1.2,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Text(
                                'In Play',
                                style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).titleLarge,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Material(
                                color: MyStyles.getContainerColor(isLightTheme: MyTheme().getThemeIsLight),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: MyStyles.getSecondaryColor(isLightTheme: MyTheme().getThemeIsLight))),
                                child: TabBar(
                                    isScrollable: false,
                                    indicator: BoxDecoration(
                                      color: MyStyles.getPrimaryColor(isLightTheme: MyTheme().getThemeIsLight),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    unselectedLabelColor: MyStyles.getSubtitleColor(isLightTheme: MyTheme().getThemeIsLight),
                                    tabs: const [
                                      Tab(
                                        text: 'Live Now',
                                      ),
                                      Tab(
                                        text: 'Upcoming',
                                      ),
                                    ]),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            AutoScaleTabBarView(children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: logic.data.matches?.length ?? 0,
                                  itemBuilder: (_, i) {
                                    return BetCardWidget(
                                      matches: logic.data.matches![i],
                                    );
                                  }),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: logic.data.upComMatche?.length ?? 0,
                                  itemBuilder: (_, i) {
                                    return UpComingBetCardWidget(
                                      matches: logic.data.upComMatche![i],
                                    );
                                  }),
                            ]),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    });
  }
}
