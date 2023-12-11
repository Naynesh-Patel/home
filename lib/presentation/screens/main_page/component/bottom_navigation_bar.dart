import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import 'main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = MainController();
    return Container(
      height: Platform.isAndroid ? 80 : 110,
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: StreamBuilder(
          initialData: 0,
          stream: controller.naveListener.stream,
          builder: (_, AsyncSnapshot<int> index) {
            int selectedIndex = index.data ?? 0;
            return BottomNavigationBar(
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedLabelStyle:
                  const TextStyle(fontSize: 14, color: blackColor),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 14, color: grayColor),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  tooltip: 'Home',
                  icon: _navIcon(KImages.home),
                  activeIcon: _navIcon(KImages.homeActive),
                  label: "Home",
                ),
                // BottomNavigationBarItem(
                //   tooltip: 'My Deals',
                //   icon: _navIcon(KImages.myDeal),
                //   activeIcon: _navIcon(KImages.myDealActive),
                //   label: 'My Deals',
                // ),
                BottomNavigationBarItem(
                  tooltip: "Saved",
                  icon: _navIcon(KImages.saved),
                  activeIcon: _navIcon(KImages.savedActive),
                  label: 'Saved',
                ),
                BottomNavigationBarItem(
                  tooltip: 'Setting',
                  activeIcon: _navIcon(KImages.settingActive),
                  icon: _navIcon(KImages.setting),
                  label: 'Setting',
                ),
              ],
              // type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              onTap: (int index) {
                controller.naveListener.sink.add(index);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _navIcon(String path) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SvgPicture.asset(path));
}
