import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:too_good_to_go_app/presentation/view/setting_view/favorite_screen/favoite_screen.dart';
import 'package:too_good_to_go_app/utils/constant/app_colors.dart';
import 'package:too_good_to_go_app/utils/constant/image_string.dart';
import 'package:too_good_to_go_app/utils/constant/sizes.dart';

import '../../setting_view/profile_screen.dart';
import '../../setting_view/setting_screen/setting_screen.dart';
import '../home_screen/home_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.house_fill, size: 24),
        inactiveIcon: const Icon(CupertinoIcons.house, size: 24),
        activeColorPrimary: AppColors.kPrimaryColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.heart_fill, size: 24),
        inactiveIcon: const Icon(CupertinoIcons.heart, size: 24),
        activeColorPrimary: AppColors.kPrimaryColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
      // PersistentBottomNavBarItem(
      //   contentPadding: 0,
      //   icon: const Icon(Iconsax.menu5, size: 24),
      //   inactiveIcon: Icon(Iconsax.menu, size: 24),
      //   activeColorPrimary: AppColors.kPrimaryColor,
      //   inactiveColorPrimary: AppColors.greyColor,
      // ),
      PersistentBottomNavBarItem(
        onPressed: (v) {
          controller.jumpToTab(0);
        },
        icon: Image.asset(
          AppImages.appLogo,
          width: 55,
        ),
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Iconsax.heart5, size: 24),
      //   inactiveIcon: Icon(Iconsax.heart, size: 24),
      //   activeColorPrimary: AppColors.kPrimaryColor,
      //   inactiveColorPrimary: AppColors.greyColor,
      // ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person, size: 24),
        inactiveIcon: Icon(Icons.person_outline, size: 24),
        activeColorPrimary: AppColors.kPrimaryColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings, size: 24),
        inactiveIcon: Icon(Icons.settings_outlined, size: 24),
        activeColorPrimary: AppColors.kPrimaryColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
    ];
  }

  List<Widget> screenList = [
    HomeScreen(),
    FavoriteScreen(),
    SizedBox(),

    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PersistentTabView(
        controller: controller,
        hideNavigationBarWhenKeyboardShows: true,
        context,
        navBarHeight: 65,
        screens: screenList,
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.simple,
        backgroundColor: Colors.grey.shade200,
        bottomScreenMargin: 0,
        decoration: const NavBarDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.borderRadiusLg * 2),
          ),
        ),
      ),
    );
  }
}
