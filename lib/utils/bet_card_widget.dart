import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/response/category_match_model.dart' as cat;
import 'package:getx_skeleton/app/data/models/response/home_screen_model.dart';
import 'package:getx_skeleton/app/routes/app_pages.dart';

import '../config/theme/my_styles.dart';
import '../config/theme/my_theme.dart';

class BetCardWidget extends StatelessWidget {
  const BetCardWidget({Key? key, required this.matches}) : super(key: key);
  final Matches matches;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: MyStyles.getContainerColor(isLightTheme: MyTheme().getThemeIsLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Image.network(
                  matches.imageUrlTeam1 ?? '',
                  height: 60.0,
                  width: 60.0,
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  matches.team1 ?? '',
                  style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).titleLarge,
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  matches.cat?.name ?? '',
                  textAlign: TextAlign.center,
                  style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).headlineSmall,
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  matches.event?.name ?? '',
                  textAlign: TextAlign.center,
                  style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodyMedium,
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.circle,
                      color: Colors.redAccent,
                      size: 18.0,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      DateTime.now().difference(DateTime.parse(matches.endDate ?? '')).inMinutes.toString(),
                      style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.BET_DETAILS_SCREEN, arguments: [matches]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                    child: Text(
                      'Bet Now',
                      style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodyLarge,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Image.network(
                  matches.imageUrlTeam2 ?? '',
                  height: 60.0,
                  width: 60.0,
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  matches.team2 ?? '',
                  style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).titleLarge,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpComingBetCardWidget extends StatelessWidget {
  const UpComingBetCardWidget({Key? key, required this.matches}) : super(key: key);
  final UpComMatche matches;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: MyStyles.getContainerColor(isLightTheme: MyTheme().getThemeIsLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Image.network(
                  matches.imageUrlTeam1 ?? '',
                  height: 60.0,
                  width: 60.0,
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  matches.team1 ?? '',
                  style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).titleLarge,
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  matches.cat?.name ?? '',
                  textAlign: TextAlign.center,
                  style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).headlineSmall,
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  matches.event?.name ?? '',
                  textAlign: TextAlign.center,
                  style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodyMedium,
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.circle,
                      color: Colors.redAccent,
                      size: 18.0,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      DateTime.now().difference(DateTime.parse(matches.endDate ?? '')).inMinutes.toString(),
                      style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.UPCOMING_BET_DETAILS_SCREEN, arguments: [matches]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                    child: Text(
                      'Bet Now',
                      style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodyLarge,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Image.network(
                  matches.imageUrlTeam2 ?? '',
                  height: 60.0,
                  width: 60.0,
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  matches.team2 ?? '',
                  style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).titleLarge,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CategoryBetCardWidget extends StatelessWidget {
  const CategoryBetCardWidget({Key? key, required this.matches, required this.isVisible}) : super(key: key);
  final cat.Matches matches;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: MyStyles.getContainerColor(isLightTheme: MyTheme().getThemeIsLight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Image.network(
                    matches.imageUrlTeam1 ?? '',
                    height: 60.0,
                    width: 60.0,
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    matches.team1 ?? '',
                    style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).titleLarge,
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    matches.cat?.name ?? '',
                    textAlign: TextAlign.center,
                    style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).headlineSmall,
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    matches.event?.name ?? '',
                    textAlign: TextAlign.center,
                    style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodyMedium,
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.circle,
                        color: Colors.redAccent,
                        size: 18.0,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        DateTime.now().difference(DateTime.parse(matches.endDate ?? '')).inMinutes.toString(),
                        style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.CATEGORY_BET_DETAILS_SCREEN, arguments: [matches]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                      child: Text(
                        'Bet Now',
                        style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).bodyLarge,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Image.network(
                    matches.imageUrlTeam2 ?? '',
                    height: 60.0,
                    width: 60.0,
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    matches.team2 ?? '',
                    style: MyStyles.getTextTheme(isLightTheme: MyTheme().getThemeIsLight).titleLarge,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}