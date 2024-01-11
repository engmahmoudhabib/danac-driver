import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/home/controllers/home_controller.dart';

class ParentScreen extends StatelessWidget {
  ParentScreen({Key? key}) : super(key: key);
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.controller,
      screens: controller.buildScreens(),
      onItemSelected: (value) {
        /*  if (value == 1) {
          controller.getProductsByCategory(0);
        } */
        /* if (value == 0) {
          controller.getSpecialProducts();
        } else */ if (value == 1) {
          controller. getProductsByCategory(controller.productsCategories[0].name);
        }/*  else if (value == 3) {
          controller.getOrders();
          controller.getMyPoints();
        } */ else if (value == 2) {
          controller.getNotifications();
        }
      },
      items: controller.navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}
