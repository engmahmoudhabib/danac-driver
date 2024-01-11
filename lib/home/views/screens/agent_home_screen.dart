// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/core/images.dart';
import 'package:storeapp/home/controllers/home_controller.dart';
import 'package:storeapp/home/views/screens/order_screen.dart';
import 'package:storeapp/home/views/screens/product_details_screen.dart';
import 'package:storeapp/home/views/screens/special_elements_screen.dart';
import 'package:storeapp/login/views/widgets/custom_textField.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:storeapp/store_management/views/widgets/input_row_item.dart';

class AgentHomeScreen extends StatelessWidget {
  AgentHomeScreen({super.key});
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                FadeInLeft(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                      ),
                    ),
                    child: FadeInUp(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.07),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                'welcome'.tr,
                                textDirection: Get.locale!.languageCode == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                'time_to_manage'.tr,
                                textDirection: Get.locale!.languageCode == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            GetStorage().read('env') == 'driver' || GetStorage().read('env') == 'proxy'
                                ? SizedBox.shrink()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: CustomTextField(
                                          controller:
                                              controller.searchController,
                                          hint: 'search_product_name'.tr,
                                          isPassword: false,
                                          prefixIcon: null,
                                          suffixIcon: null,
                                          textInputAction: TextInputAction.done,
                                          textInputType:
                                              TextInputType.emailAddress,
                                          onSubmitted: (val) => controller
                                              .getSearchProducts(false),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            String barcodeScanRes =
                                                await FlutterBarcodeScanner
                                                    .scanBarcode(
                                              '#FF3758',
                                              'cancel'.tr,
                                              true,
                                              ScanMode.BARCODE,
                                            );
                                            if (barcodeScanRes != '-1') {
                                              controller.searchController
                                                  ?.text = barcodeScanRes;
                                            } else {
                                              controller.searchController
                                                  ?.clear();
                                            }

                                            controller.getSearchProducts(true);
                                          },
                                          child: Image.asset(AppImages.bacode)),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                controller.isLoadingSearch.value == true
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.red,
                          ),
                        ),
                      )
                    : Column(
                        children: GetStorage().read('env') == 'driver' || GetStorage().read('env') == 'proxy'
                            ? [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.63,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: DefaultTabController(
                                    length: 2,
                                    child: Scaffold(
                                      appBar: AppBar(
                                        backgroundColor: Colors.white,
                                        elevation: 0,
                                        flexibleSpace: SizedBox(
                                          height: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TabBar(
                                                indicatorColor: Colors.black,
                                                onTap: (value) {
                                                  if (value == 0) {
                                                    controller.getDriverOrders(
                                                        "True");
                                                  } else if (value == 1) {
                                                    controller.getDriverOrders(
                                                        "False");
                                                  }
                                                },
                                                indicatorPadding:
                                                    EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                ),
                                                tabs: [
                                                  Tab(
                                                    icon: Text(
                                                      'new_orders'.tr,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  Tab(
                                                    icon: Text(
                                                      'old_orders'.tr,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      body: TabBarView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: [
                                          controller.isLoading.value == true
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: AppColors.red,
                                                  ),
                                                )
                                              : Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: Container(
                                                        height: 42,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        color: AppColors.pink,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: 'orders_num'
                                                                          .tr,
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColors
                                                                            .brown,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          " (${controller.driverOrders.length})",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.42,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.88,
                                                      child: AnimationLimiter(
                                                        child: GridView.count(
                                                          crossAxisCount: 1,
                                                          shrinkWrap: true,
                                                          childAspectRatio:
                                                              7 / 5,
                                                          children:
                                                              List.generate(
                                                            controller
                                                                .driverOrders
                                                                .length,
                                                            (int index) {
                                                              return AnimationConfiguration
                                                                  .staggeredGrid(
                                                                position: index,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            375),
                                                                columnCount: 1,
                                                                child:
                                                                    ScaleAnimation(
                                                                  child:
                                                                      FadeInAnimation(
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        controller.getDriverOrder(controller
                                                                            .driverOrders[index]
                                                                            .id);
                                                                        PersistentNavBarNavigator
                                                                            .pushNewScreen(
                                                                          context,
                                                                          screen:
                                                                              OrderScreen(
                                                                            orderNum:
                                                                                controller.driverOrders[index].id,
                                                                          ),
                                                                          withNavBar:
                                                                              true,
                                                                          pageTransitionAnimation:
                                                                              PageTransitionAnimation.cupertino,
                                                                        );
                                                                      },
                                                                      child:
                                                                          Card(
                                                                        elevation:
                                                                            5,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15.0),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(11.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: MediaQuery.of(context).size.width * 0.4,
                                                                                    child: RichText(
                                                                                      text: TextSpan(
                                                                                        children: [],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: MediaQuery.of(context).size.width * 0.4,
                                                                                    child: RichText(
                                                                                      textAlign: TextAlign.end,
                                                                                      text: TextSpan(
                                                                                        children: [
                                                                                          TextSpan(
                                                                                            text: controller.driverOrders[index].outputReceipt.date.substring(0 ,controller.driverOrders[index].outputReceipt.date.indexOf('T') ),
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                              fontSize: 16,
                                                                                              fontWeight: FontWeight.w400,
                                                                                            ),
                                                                                          ),
                                                                                          WidgetSpan(
                                                                                            child: Icon(
                                                                                              Icons.calendar_month,
                                                                                              color: Colors.black,
                                                                                              size: 18,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Divider(
                                                                              color: Colors.black,
                                                                              indent: 10,
                                                                              endIndent: 10,
                                                                            ),
                                                                            inputRowItem(
                                                                              text: "order_number".tr,
                                                                              total: controller.driverOrders[index].id.toString(),
                                                                            ),
                                                                            inputRowItem(
                                                                              text: "products_num".tr,
                                                                              total: controller.driverOrders[index].outputReceipt.products.length.toString(),
                                                                            ),
                                                                            inputRowItem(
                                                                              text: "tota".tr,
                                                                              total: controller.driverOrders[index].outputReceipt.remainingAmount.toString(),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          controller.isLoading.value == true
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: AppColors.red,
                                                  ),
                                                )
                                              : Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: Container(
                                                        height: 42,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        color: AppColors.pink,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: 'orders_num'
                                                                          .tr,
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColors
                                                                            .brown,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          " (${controller.driverOrders.length})",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.42,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.88,
                                                      child: AnimationLimiter(
                                                        child: GridView.count(
                                                          crossAxisCount: 1,
                                                          shrinkWrap: true,
                                                          childAspectRatio:
                                                              7 / 5,
                                                          children:
                                                              List.generate(
                                                            controller
                                                                .driverOrders
                                                                .length,
                                                            (int index) {
                                                              return AnimationConfiguration
                                                                  .staggeredGrid(
                                                                position: index,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            375),
                                                                columnCount: 1,
                                                                child:
                                                                    ScaleAnimation(
                                                                  child:
                                                                      FadeInAnimation(
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        controller.getDriverOrder(controller
                                                                            .driverOrders[index]
                                                                            .id);
                                                                        PersistentNavBarNavigator
                                                                            .pushNewScreen(
                                                                          context,
                                                                          screen:
                                                                              OrderScreen(
                                                                            orderNum:
                                                                                controller.driverOrders[index].id,
                                                                          ),
                                                                          withNavBar:
                                                                              true,
                                                                          pageTransitionAnimation:
                                                                              PageTransitionAnimation.cupertino,
                                                                        );
                                                                      },
                                                                      child:
                                                                          Card(
                                                                        elevation:
                                                                            5,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15.0),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(11.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: MediaQuery.of(context).size.width * 0.4,
                                                                                    child: RichText(
                                                                                      text: TextSpan(
                                                                                        children: [],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: MediaQuery.of(context).size.width * 0.4,
                                                                                    child: RichText(
                                                                                      textAlign: TextAlign.end,
                                                                                      text: TextSpan(
                                                                                        children: [
                                                                                          TextSpan(
                                                                                            text: controller.driverOrders[index].outputReceipt.date.substring(0 ,controller.driverOrders[index].outputReceipt.date.indexOf('T') ),
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                              fontSize: 16,
                                                                                              fontWeight: FontWeight.w400,
                                                                                            ),
                                                                                          ),
                                                                                          WidgetSpan(
                                                                                            child: Icon(
                                                                                              Icons.calendar_month,
                                                                                              color: Colors.black,
                                                                                              size: 18,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Divider(
                                                                              color: Colors.black,
                                                                              indent: 10,
                                                                              endIndent: 10,
                                                                            ),
                                                                            inputRowItem(
                                                                              text: "order_number".tr,
                                                                              total: controller.driverOrders[index].id.toString(),
                                                                            ),
                                                                            inputRowItem(
                                                                              text: "products_num".tr,
                                                                              total: controller.driverOrders[index].outputReceipt.products.length.toString(),
                                                                            ),
                                                                            inputRowItem(
                                                                              text: "tota".tr,
                                                                              total: controller.driverOrders[index].outputReceipt.remainingAmount.toString(),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ]
                            : [
                                controller.searchProducts.isEmpty
                                    ? Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  child: Text(
                                                    'special_products'.tr,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  child: InkWell(
                                                    onTap: () {
                                                      PersistentNavBarNavigator
                                                          .pushNewScreen(
                                                        context,
                                                        screen:
                                                            SpecialElementsScreen(
                                                          type: 0,
                                                        ),
                                                        withNavBar: true,
                                                        pageTransitionAnimation:
                                                            PageTransitionAnimation
                                                                .cupertino,
                                                      );
                                                    },
                                                    child: Text(
                                                      'see_all'.tr,
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          controller.isLoading.value == true
                                              ? SizedBox(
                                                  height: 200,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: AppColors.red,
                                                    ),
                                                  ),
                                                )
                                              : CarouselSlider(
                                                  options: CarouselOptions(
                                                    height: 200.0,
                                                    viewportFraction: 0.35,
                                                    initialPage: 0,
                                                    enableInfiniteScroll: false,
                                                    reverse: false,
                                                    autoPlay: true,
                                                  ),
                                                  items: controller
                                                      .specialProducts
                                                      .map((i) {
                                                    return Builder(
                                                      builder: (BuildContext
                                                          context) {
                                                        return InkWell(
                                                          onTap: () {
                                                            PersistentNavBarNavigator
                                                                .pushNewScreen(
                                                              context,
                                                              screen:
                                                                  ProductDetailsScreen(
                                                                productName:
                                                                    i.name,
                                                                url: i.image,
                                                                details: i
                                                                    .description,
                                                                units: i
                                                                    .numPerItem
                                                                    .toString(),
                                                                cartoon: i
                                                                    .itemPerCarton
                                                                    .toString(),
                                                                category:
                                                                    i.category,
                                                                cartoonPrice: i
                                                                    .salePrice
                                                                    .toString(),
                                                                id: i.id,
                                                              ),
                                                              withNavBar: true,
                                                              pageTransitionAnimation:
                                                                  PageTransitionAnimation
                                                                      .cupertino,
                                                            );
                                                          },
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 150,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.3,
                                                                child: Card(
                                                                  elevation: 5,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                      child: Image
                                                                          .network(
                                                                        i.image,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              FadeInLeft(
                                                                child: SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.3,
                                                                  height: 29,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      PersistentNavBarNavigator
                                                                          .pushNewScreen(
                                                                        context,
                                                                        screen:
                                                                            ProductDetailsScreen(
                                                                          productName:
                                                                              i.name,
                                                                          url: i
                                                                              .image,
                                                                          details:
                                                                              i.description,
                                                                          units: i
                                                                              .numPerItem
                                                                              .toString(),
                                                                          cartoon: i
                                                                              .itemPerCarton
                                                                              .toString(),
                                                                          category:
                                                                              i.category,
                                                                          cartoonPrice: i
                                                                              .salePrice
                                                                              .toString(),
                                                                          id: i
                                                                              .id,
                                                                        ),
                                                                        withNavBar:
                                                                            true,
                                                                        pageTransitionAnimation:
                                                                            PageTransitionAnimation.cupertino,
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      i.name,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<
                                                                              Color>(
                                                                          AppColors
                                                                              .red),
                                                                      shape: MaterialStateProperty
                                                                          .all<
                                                                              RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                          side:
                                                                              BorderSide(
                                                                            color:
                                                                                AppColors.red,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }).toList(),
                                                ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  child: Text(
                                                    'most_sale_products'.tr,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  child: InkWell(
                                                    onTap: () {
                                                      PersistentNavBarNavigator
                                                          .pushNewScreen(
                                                        context,
                                                        screen:
                                                            SpecialElementsScreen(
                                                          type: 1,
                                                        ),
                                                        withNavBar: true,
                                                        pageTransitionAnimation:
                                                            PageTransitionAnimation
                                                                .cupertino,
                                                      );
                                                    },
                                                    child: Text(
                                                      'see_all'.tr,
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          controller.isLoading.value == true
                                              ? SizedBox(
                                                  height: 200,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: AppColors.red,
                                                    ),
                                                  ),
                                                )
                                              : CarouselSlider(
                                                  options: CarouselOptions(
                                                    height: 200.0,
                                                    viewportFraction: 0.35,
                                                    initialPage: 0,
                                                    enableInfiniteScroll: false,
                                                    reverse: false,
                                                    autoPlay: true,
                                                  ),
                                                  items: controller
                                                      .specialProducts
                                                      .map((i) {
                                                    return Builder(
                                                      builder: (BuildContext
                                                          context) {
                                                        return InkWell(
                                                          onTap: () {
                                                            PersistentNavBarNavigator
                                                                .pushNewScreen(
                                                              context,
                                                              screen:
                                                                  ProductDetailsScreen(
                                                                productName:
                                                                    i.name,
                                                                url: i.image,
                                                                details: i
                                                                    .description,
                                                                units: i
                                                                    .numPerItem
                                                                    .toString(),
                                                                cartoon: i
                                                                    .itemPerCarton
                                                                    .toString(),
                                                                category:
                                                                    i.category,
                                                                cartoonPrice: i
                                                                    .salePrice
                                                                    .toString(),
                                                                id: i.id,
                                                              ),
                                                              withNavBar: true,
                                                              pageTransitionAnimation:
                                                                  PageTransitionAnimation
                                                                      .cupertino,
                                                            );
                                                          },
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 150,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.3,
                                                                child: Card(
                                                                  elevation: 5,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                      child: Image
                                                                          .network(
                                                                        i.image,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              FadeInLeft(
                                                                child: SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.3,
                                                                  height: 29,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      PersistentNavBarNavigator
                                                                          .pushNewScreen(
                                                                        context,
                                                                        screen:
                                                                            ProductDetailsScreen(
                                                                          productName:
                                                                              i.name,
                                                                          url: i
                                                                              .image,
                                                                          details:
                                                                              i.description,
                                                                          units: i
                                                                              .numPerItem
                                                                              .toString(),
                                                                          cartoon: i
                                                                              .itemPerCarton
                                                                              .toString(),
                                                                          category:
                                                                              i.category,
                                                                          cartoonPrice: i
                                                                              .salePrice
                                                                              .toString(),
                                                                          id: i
                                                                              .id,
                                                                        ),
                                                                        withNavBar:
                                                                            true,
                                                                        pageTransitionAnimation:
                                                                            PageTransitionAnimation.cupertino,
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      i.name,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<
                                                                              Color>(
                                                                          AppColors
                                                                              .red),
                                                                      shape: MaterialStateProperty
                                                                          .all<
                                                                              RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                          side:
                                                                              BorderSide(
                                                                            color:
                                                                                AppColors.red,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }).toList(),
                                                ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  child: Text(
                                                    'new_products'.tr,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  child: InkWell(
                                                    onTap: () {
                                                      PersistentNavBarNavigator
                                                          .pushNewScreen(
                                                        context,
                                                        screen:
                                                            SpecialElementsScreen(
                                                          type: 2,
                                                        ),
                                                        withNavBar: true,
                                                        pageTransitionAnimation:
                                                            PageTransitionAnimation
                                                                .cupertino,
                                                      );
                                                    },
                                                    child: Text(
                                                      'see_all'.tr,
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          controller.isLoading.value == true
                                              ? SizedBox(
                                                  height: 200,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: AppColors.red,
                                                    ),
                                                  ),
                                                )
                                              : CarouselSlider(
                                                  options: CarouselOptions(
                                                    height: 200.0,
                                                    viewportFraction: 0.35,
                                                    initialPage: 0,
                                                    enableInfiniteScroll: false,
                                                    reverse: false,
                                                    autoPlay: true,
                                                  ),
                                                  items: controller
                                                      .specialProducts
                                                      .map((i) {
                                                    return Builder(
                                                      builder: (BuildContext
                                                          context) {
                                                        return InkWell(
                                                          onTap: () {
                                                            PersistentNavBarNavigator
                                                                .pushNewScreen(
                                                              context,
                                                              screen:
                                                                  ProductDetailsScreen(
                                                                productName:
                                                                    i.name,
                                                                url: i.image,
                                                                details: i
                                                                    .description,
                                                                units: i
                                                                    .numPerItem
                                                                    .toString(),
                                                                cartoon: i
                                                                    .itemPerCarton
                                                                    .toString(),
                                                                category:
                                                                    i.category,
                                                                cartoonPrice: i
                                                                    .salePrice
                                                                    .toString(),
                                                                id: i.id,
                                                              ),
                                                              withNavBar: true,
                                                              pageTransitionAnimation:
                                                                  PageTransitionAnimation
                                                                      .cupertino,
                                                            );
                                                          },
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 150,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.3,
                                                                child: Card(
                                                                  elevation: 5,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                      child: Image
                                                                          .network(
                                                                        i.image,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              FadeInLeft(
                                                                child: SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.3,
                                                                  height: 29,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      PersistentNavBarNavigator
                                                                          .pushNewScreen(
                                                                        context,
                                                                        screen:
                                                                            ProductDetailsScreen(
                                                                          productName:
                                                                              i.name,
                                                                          url: i
                                                                              .image,
                                                                          details:
                                                                              i.description,
                                                                          units: i
                                                                              .numPerItem
                                                                              .toString(),
                                                                          cartoon: i
                                                                              .itemPerCarton
                                                                              .toString(),
                                                                          category:
                                                                              i.category,
                                                                          cartoonPrice: i
                                                                              .salePrice
                                                                              .toString(),
                                                                          id: i
                                                                              .id,
                                                                        ),
                                                                        withNavBar:
                                                                            true,
                                                                        pageTransitionAnimation:
                                                                            PageTransitionAnimation.cupertino,
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      i.name,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<
                                                                              Color>(
                                                                          AppColors
                                                                              .red),
                                                                      shape: MaterialStateProperty
                                                                          .all<
                                                                              RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                          side:
                                                                              BorderSide(
                                                                            color:
                                                                                AppColors.red,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }).toList(),
                                                ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'search_results'.tr,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 32,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller.searchProducts.clear();
                                              controller.searchProducts
                                                  .refresh();
                                              controller.searchController
                                                  ?.clear();
                                            },
                                            child: Text(
                                              'back'.tr,
                                              style: TextStyle(
                                                color: AppColors.red,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.7,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: GridView.count(
                                              primary: false,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 5,
                                              childAspectRatio: 3.5 / 5.8,
                                              children: List.generate(
                                                  controller.searchProducts
                                                      .length, (index) {
                                                return Stack(
                                                  children: [
                                                    SizedBox(
                                                      height: 150,
                                                      width:double.infinity,
                                                      child: InkWell(
                                                        onTap: () {
                                                          PersistentNavBarNavigator
                                                              .pushNewScreen(
                                                            context,
                                                            screen:
                                                                ProductDetailsScreen(
                                                              productName:
                                                                  controller
                                                                      .searchProducts[
                                                                          index]
                                                                      .name,
                                                              url: controller
                                                                  .searchProducts[
                                                                      index]
                                                                  .image,
                                                              details: controller
                                                                  .searchProducts[
                                                                      index]
                                                                  .description,
                                                              units: controller
                                                                  .searchProducts[
                                                                      index]
                                                                  .numPerItem
                                                                  .toString(),
                                                              cartoon: controller
                                                                  .searchProducts[
                                                                      index]
                                                                  .itemPerCarton
                                                                  .toString(),
                                                              category: controller
                                                                  .searchProducts[
                                                                      index]
                                                                  .category,
                                                              cartoonPrice: controller
                                                                  .searchProducts[
                                                                      index]
                                                                  .salePrice
                                                                  .toString(),
                                                              id: controller
                                                                  .searchProducts[
                                                                      index]
                                                                  .id,
                                                            ),
                                                            withNavBar: true,
                                                            pageTransitionAnimation:
                                                                PageTransitionAnimation
                                                                    .cupertino,
                                                          );
                                                        },
                                                        child: Card(
                                                          elevation: 5,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                              child:
                                                                  Image.network(
                                                                controller
                                                                    .searchProducts[
                                                                        index]
                                                                    .image,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    Positioned(
                                                      top: 160,
                                                      right: 5,
                                                      child: FadeInLeft(
                                                        child: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.27,
                                                          height: 29,
                                                          child: ElevatedButton(
                                                            onPressed: () {},
                                                            child: Text(
                                                              controller
                                                                  .searchProducts[
                                                                      index]
                                                                  .name,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      AppColors
                                                                          .red),
                                                              shape: MaterialStateProperty
                                                                  .all<
                                                                      RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  side:
                                                                      BorderSide(
                                                                    color:
                                                                        AppColors
                                                                            .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      )
                              ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
