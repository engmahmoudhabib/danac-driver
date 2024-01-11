import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/home/controllers/home_controller.dart';
import 'package:storeapp/home/views/widgets/add_order2_dialog.dart';
import 'package:storeapp/home/views/widgets/add_order_dialog.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

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
          'cartt'.tr,
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
                  child: CircularProgressIndicator(
                    color: AppColors.red,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: (GetStorage().read('env') == 'agent')
                        ? [
                            SizedBox(
                              height: 20,
                            ),
                            controller.cartItems.isEmpty
                                ? Center(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.shopping_cart_outlined,
                                            color: Colors.grey,
                                            size: 80,
                                          ),
                                          Text(
                                            'cart_empty'.tr,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.68,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: AnimationLimiter(
                                      child: GridView.count(
                                        crossAxisCount: 1,
                                        childAspectRatio: 5 / 2,
                                        children: List.generate(
                                          controller.cartItems.length,
                                          (int index) {
                                            return AnimationConfiguration
                                                .staggeredGrid(
                                              position: index,
                                              duration: const Duration(
                                                  milliseconds: 375),
                                              columnCount: 2,
                                              child: ScaleAnimation(
                                                child: FadeInAnimation(
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Card(
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
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
                                                                      0.2,
                                                                  height: 75,
                                                                  child: Card(
                                                                    elevation:
                                                                        5,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                        child: Image
                                                                            .network(
                                                                          controller
                                                                              .cartItems[index]
                                                                              .products
                                                                              .image,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.2,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        '${controller.cartItems[index].products.name}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        '${controller.cartItems[index].products.description}',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                      Text(
                                                                        '${controller.cartItems[index].products.salePrice}',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                AppColors.red),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      controller.deleteProduct(controller
                                                                          .cartItems[
                                                                              index]
                                                                          .id);
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 25,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.035,
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  width: 120,
                                                                  child: Card(
                                                                    elevation:
                                                                        5,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            controller.addSub(true,
                                                                                controller.cartItems[index].id);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            '+',
                                                                            style:
                                                                                TextStyle(fontSize: 15),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${controller.cartItems[index].quantity}',
                                                                          style:
                                                                              TextStyle(fontSize: 15),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            controller.addSub(false,
                                                                                controller.cartItems[index].id);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            '-',
                                                                            style:
                                                                                TextStyle(fontSize: 20),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Column(
                                      children: [
                                        Text(
                                          'tota'.tr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${controller.cartItemsTotalPrice}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: AppColors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FadeInLeft(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 45,
                                      child: controller.isLoading.value == true
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.red,
                                              ),
                                            )
                                          : ElevatedButton(
                                              onPressed: () {
                                                addOrderDialog(
                                                    context, controller);
                                              },
                                              child: Text(
                                                'order'.tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(AppColors.red),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    side: BorderSide(
                                                      color: AppColors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]
                        : [
                            SizedBox(
                              height: 20,
                            ),
                            controller.cartMedium2Items.isEmpty
                                ? Center(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.shopping_cart_outlined,
                                            color: Colors.grey,
                                            size: 80,
                                          ),
                                          Text(
                                            'cart_empty'.tr,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.68,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: AnimationLimiter(
                                      child: GridView.count(
                                        crossAxisCount: 1,
                                        childAspectRatio: 5 / 2,
                                        children: List.generate(
                                          controller.cartMedium2Items.length,
                                          (int index) {
                                            return AnimationConfiguration
                                                .staggeredGrid(
                                              position: index,
                                              duration: const Duration(
                                                  milliseconds: 375),
                                              columnCount: 2,
                                              child: ScaleAnimation(
                                                child: FadeInAnimation(
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Card(
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
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
                                                                      0.2,
                                                                  height: 120,
                                                                  child: Card(
                                                                    elevation:
                                                                        5,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      controller
                                                                          .cartMedium2Items[
                                                                              index]
                                                                          .image,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.2,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        '${controller.cartMedium2Items[index].product}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        '${controller.cartMedium2Items[index].description}',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                      Text(
                                                                        '${controller.cartMedium2Items[index].salePrice}',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                AppColors.red),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      controller.deleteProductFromMediumTwo(controller
                                                                          .cartMedium2Items[
                                                                              index]
                                                                          .id);
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 25,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.05,
                                                                ),
                                                                Container(
                                                                  height: 30,
                                                                  width: 100,
                                                                  child: Card(
                                                                    elevation:
                                                                        5,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15.0),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            controller.addSubMediumTwo(true,
                                                                                controller.cartMedium2Items[index].id);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            '+',
                                                                            style:
                                                                                TextStyle(fontSize: 15),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${controller.cartMedium2Items[index].quantity}',
                                                                          style:
                                                                              TextStyle(fontSize: 15),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            controller.addSubMediumTwo(false,
                                                                                controller.cartMedium2Items[index].id);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            '-',
                                                                            style:
                                                                                TextStyle(fontSize: 20),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Column(
                                      children: [
                                        Text(
                                          'tota'.tr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${controller.cartItemsTotalPrice}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: AppColors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FadeInLeft(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 45,
                                      child: controller.isLoading.value == true
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.red,
                                              ),
                                            )
                                          : ElevatedButton(
                                              onPressed: () {
                                                addOrder2Dialog(
                                                    context, controller);
                                              },
                                              child: Text(
                                                'order'.tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(AppColors.red),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    side: BorderSide(
                                                      color: AppColors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                  ),
                ),
        ),
      ),
    );
  }
}
