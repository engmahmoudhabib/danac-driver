// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/home/controllers/home_controller.dart';
import 'package:storeapp/home/views/screens/navigation_screen.dart';

class OrderScreen extends StatelessWidget {
  final int orderNum;
  OrderScreen({
    super.key,
    required this.orderNum,
  });

  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'order_num'.tr + ' #$orderNum',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => controller.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.red),
                )
              :/* ( GetStorage().read('env') != 'driver')
                  ? Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            children: [
                              Text(
                                'order_data'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.82,
                          height: 200,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'order_date'.tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    controller.order.first.created,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    'contact_info'.tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'name'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        controller.order.first.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'serial'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 53,
                                      ),
                                      Text(
                                        controller.order.first.clientId
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'phone'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        controller.order.first.phonenumber,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            children: [
                              Text(
                                'order_details'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.82,
                          height: MediaQuery.of(context).size.height * 0.44,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    height: 42,
                                    width: MediaQuery.of(context).size.width *
                                        0.82,
                                    color: AppColors.pink,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.19,
                                          child: Text(
                                            "product".tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.19,
                                          child: Text(
                                            "price".tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.19,
                                          child: Text(
                                            "quantity".tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.19,
                                          child: Text(
                                            "total".tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.328,
                                  child: AnimationLimiter(
                                    child: GridView.count(
                                      crossAxisCount: 1,
                                      shrinkWrap: true,
                                      children: List.generate(
                                        controller.order.first.products.length,
                                        (int index) {
                                          return AnimationConfiguration
                                              .staggeredGrid(
                                            position: index,
                                            duration: const Duration(
                                                milliseconds: 375),
                                            columnCount: 1,
                                            child: ScaleAnimation(
                                              child: FadeInAnimation(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                      child: Row(
                                                        children: [
                                                          Card(
                                                            elevation: 5,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            child: SizedBox(
                                                              height: 50,
                                                              width: 50,
                                                              child:
                                                                  Image.network(
                                                                controller
                                                                    .order
                                                                    .first
                                                                    .products[
                                                                        index]
                                                                    .image,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                      child: Text(
                                                        (controller
                                                                    .order
                                                                    .first
                                                                    .products[
                                                                        index]
                                                                    .totalPrice /
                                                                controller
                                                                    .order
                                                                    .first
                                                                    .products[
                                                                        index]
                                                                    .quantity)
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                      child: Text(
                                                        controller
                                                            .order
                                                            .first
                                                            .products[index]
                                                            .quantity
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.19,
                                                      child: Text(
                                                        controller
                                                            .order
                                                            .first
                                                            .products[index]
                                                            .totalPrice
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: AppColors.red,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    height: 42,
                                    width: MediaQuery.of(context).size.width *
                                        0.82,
                                    color: AppColors.pink,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.39,
                                          child: Text(
                                            "tota".tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.39,
                                          child: Text(
                                            controller.order.first.total
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : */ SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              children: [
                                Text(
                                  'client_data'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.82,
                            height: 200,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'order_address'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: AppColors.red,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'city'.tr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          controller.driverOrder.first.receipt
                                              .address,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      'contact_info'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: AppColors.red,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'name'.tr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          "${controller.driverOrder.first.receipt.clientName}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'serial'.tr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 53,
                                        ),
                                        Text(
                                          controller
                                              .driverOrder.first.receipt.client
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'phone'.tr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          controller.driverOrder.first.receipt
                                              .phonenumber,
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              children: [
                                Text(
                                  'products'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.82,
                            height: MediaQuery.of(context).size.height * 0.44,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: 42,
                                      width: MediaQuery.of(context).size.width *
                                          0.82,
                                      color: AppColors.pink,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.19,
                                            child: Text(
                                              "product".tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.19,
                                            child: Text(
                                              "price".tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.19,
                                            child: Text(
                                              "quantity".tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.19,
                                            child: Text(
                                              "total".tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.328,
                                    child: AnimationLimiter(
                                      child: GridView.count(
                                        crossAxisCount: 1,
                                        shrinkWrap: true,
                                        children: List.generate(
                                          controller.driverOrder.first.products
                                              .length,
                                          (int index) {
                                            return AnimationConfiguration
                                                .staggeredGrid(
                                              position: index,
                                              duration: const Duration(
                                                  milliseconds: 375),
                                              columnCount: 1,
                                              child: ScaleAnimation(
                                                child: FadeInAnimation(
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
                                                            0.19,
                                                        child: Row(
                                                          children: [
                                                            Card(
                                                              elevation: 5,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0),
                                                              ),
                                                              child: SizedBox(
                                                                height: 50,
                                                                width: 50,
                                                                child: Image
                                                                    .network(
                                                                  controller
                                                                      .driverOrder
                                                                      .first
                                                                      .products[
                                                                          index]
                                                                      .image,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.19,
                                                        child: Text(
                                                          (controller
                                                                      .driverOrder
                                                                      .first
                                                                      .products[
                                                                          index]
                                                                      .total /
                                                                  controller
                                                                      .driverOrder
                                                                      .first
                                                                      .products[
                                                                          index]
                                                                      .quantity)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.19,
                                                        child: Text(
                                                          controller
                                                              .driverOrder
                                                              .first
                                                              .products[index]
                                                              .quantity
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.19,
                                                        child: Text(
                                                          controller
                                                              .driverOrder
                                                              .first
                                                              .products[index]
                                                              .total
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.red,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: 42,
                                      width: MediaQuery.of(context).size.width *
                                          0.82,
                                      color: AppColors.pink,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.39,
                                            child: Text(
                                              "tota".tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.39,
                                            child: Text(
                                              controller.driverOrder.first
                                                  .receipt.remainingAmount
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
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
                            height: 50,
                          ),
                          controller.isGettingLocation.value == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.red,
                                  ),
                                )
                              : SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 45,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Location _location = Location();
                                      bool? _serviceEnabled;
                                      PermissionStatus? _permissionGranted;
                                      LatLng? _currentLatLng;

                                      checkUserLocation() async {
                                        controller.isGettingLocation.value =
                                            true;
                                        _serviceEnabled =
                                            await _location.serviceEnabled();
                                        if (!_serviceEnabled!) {
                                          _serviceEnabled =
                                              await _location.requestService();
                                        }
                                        _permissionGranted =
                                            await _location.hasPermission();
                                        if (_permissionGranted ==
                                            PermissionStatus.denied) {
                                          _permissionGranted = await _location
                                              .requestPermission();
                                        }
                                        LocationData _locationData =
                                            await _location.getLocation();

                                        _currentLatLng = LatLng(
                                            _locationData.latitude!,
                                            _locationData.longitude!);
                                        controller.isGettingLocation.value =
                                            false;
                                        return _currentLatLng;
                                      }

                                      String latlng = controller
                                          .driverOrder.first.receipt.location
                                          .substring(
                                              controller.driverOrder.first
                                                      .receipt.location
                                                      .indexOf('(') +
                                                  1,
                                              controller.driverOrder.first
                                                  .receipt.location
                                                  .indexOf(')'));
                                      double lng = double.parse(latlng
                                          .substring(0, latlng.indexOf(' ')));
                                      double lat = double.parse(latlng
                                          .substring(latlng.indexOf(' ') + 1));
                                      checkUserLocation().then(
                                        (value) => Get.to(
                                          NavigationScreen(
                                            lat: lat,
                                            long: lng,
                                            sourceLat: value!.latitude,
                                            sourceLng: value!.longitude,
                                          ), 
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'accept_and_continue'.tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              AppColors.red),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: BorderSide(
                                            color: AppColors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
