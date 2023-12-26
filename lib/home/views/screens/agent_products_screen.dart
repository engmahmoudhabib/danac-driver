import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/home/controllers/home_controller.dart';
import 'package:storeapp/home/views/screens/product_details_screen.dart';

class AgentProductsScreen extends StatelessWidget {
  AgentProductsScreen({super.key});
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        backgroundColor: Colors.white,
     
        title: Text(
          'products'.tr,
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
          () => DefaultTabController(
            length: 3,
            child: new Scaffold(
              appBar: new AppBar(
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                elevation: 0,
                flexibleSpace: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    new TabBar(
                      indicatorColor: Colors.black,
                      onTap: (value) {
                        controller.getProductsByCategory(value);
                      },
                      indicatorPadding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      tabs: [
                        Text(
                          'food'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'drinks'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'others'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  controller.isLoading.value == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.red,
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.68,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: AnimationLimiter(
                              child: GridView.count(
                                crossAxisCount: 3,
                                childAspectRatio: 11 / 18.5,
                                children: List.generate(
                                  controller.allProducts.length,
                                  (int index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: InkWell(
                                            onTap: () {
                                                PersistentNavBarNavigator
                                                                  .pushNewScreen(
                                                                context,
                                                                screen:
                                                                    ProductDetailsScreen(
                                                                  productName:
                                                                      controller.allProducts[index].name.toString(),
                                                                  url: controller.allProducts[index].image.toString(),
                                                                  details: controller.allProducts[index]
                                                                      .description.toString(),
                                                                  units: controller.allProducts[index]
                                                                      .numPerItem
                                                                      .toString(),
                                                                  cartoon: controller.allProducts[index]
                                                                      .itemPerCarton
                                                                      .toString(),
                                                                  category: controller.allProducts[index]
                                                                      .category,
                                                                  cartoonPrice: controller.allProducts[index]
                                                                      .salePrice
                                                                      .toString(),
                                                                  id: controller.allProducts[index].id,
                                                                ),
                                                                withNavBar:
                                                                    true,
                                                                pageTransitionAnimation:
                                                                    PageTransitionAnimation
                                                                        .cupertino,
                                                              );
                                            },
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 150,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      child: Image.network( 
                                                        controller
                                                            .allProducts[index]
                                                            .image,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  FadeInLeft(
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.29,
                                                      height: 31,
                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                          controller.allProducts[index].name,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      AppColors
                                                                          .red),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              side: BorderSide(
                                                                color: AppColors
                                                                    .red,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                        ),
                  controller.isLoading.value == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.red,
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.68,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: AnimationLimiter(
                              child: GridView.count(
                                crossAxisCount: 3,
                                childAspectRatio: 11 / 18.5,
                                children: List.generate(
                                  controller.allProducts.length,
                                  (int index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: InkWell(
                                            onTap: () {
                                                  PersistentNavBarNavigator
                                                                  .pushNewScreen(
                                                                context,
                                                                screen:
                                                                    ProductDetailsScreen(
                                                                  productName:
                                                                      controller.allProducts[index].name,
                                                                  url: controller.allProducts[index].image,
                                                                  details: controller.allProducts[index]
                                                                      .description,
                                                                  units: controller.allProducts[index]
                                                                      .numPerItem
                                                                      .toString(),
                                                                  cartoon: controller.allProducts[index]
                                                                      .itemPerCarton
                                                                      .toString(),
                                                                  category: controller.allProducts[index]
                                                                      .category,
                                                                  cartoonPrice: controller.allProducts[index]
                                                                      .salePrice
                                                                      .toString(),
                                                                   id: controller.allProducts[index].id,
                                                                ),
                                                                withNavBar:
                                                                    true,
                                                                pageTransitionAnimation:
                                                                    PageTransitionAnimation
                                                                        .cupertino,
                                                              );
                                            },
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 150,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      child: Image.network(
                                                        controller
                                                            .allProducts[index]
                                                            .image,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  FadeInLeft(
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.29,
                                                      height: 31,
                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                          controller.allProducts[index].name,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      AppColors
                                                                          .red),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              side: BorderSide(
                                                                color: AppColors
                                                                    .red,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                        ),
                  controller.isLoading.value == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.red,
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.68,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: AnimationLimiter(
                              child: GridView.count(
                                crossAxisCount: 3,
                                childAspectRatio: 11 / 18.5,
                                children: List.generate(
                                  controller.allProducts.length,
                                  (int index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: InkWell(
                                            onTap: () {    PersistentNavBarNavigator
                                                                  .pushNewScreen(
                                                                context,
                                                                screen:
                                                                    ProductDetailsScreen(
                                                                  productName:
                                                                      controller.allProducts[index].name,
                                                                  url: controller.allProducts[index].image,
                                                                  details: controller.allProducts[index]
                                                                      .description.toString(),
                                                                  units: controller.allProducts[index]
                                                                      .numPerItem
                                                                      .toString(),
                                                                  cartoon: controller.allProducts[index]
                                                                      .itemPerCarton
                                                                      .toString(),
                                                                  category: controller.allProducts[index]
                                                                      .category,
                                                                  cartoonPrice: controller.allProducts[index]
                                                                      .salePrice
                                                                      .toString(),
                                                                    id: controller.allProducts[index].id,
                                                                ),
                                                                withNavBar:
                                                                    true,
                                                                pageTransitionAnimation:
                                                                    PageTransitionAnimation
                                                                        .cupertino,
                                                              );},
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 150,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      child: Image.network(
                                                        controller
                                                            .allProducts[index]
                                                            .image,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  FadeInLeft(
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.29,
                                                      height: 31,
                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                         controller.allProducts[index].name,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      AppColors
                                                                          .red),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              side: BorderSide(
                                                                color: AppColors
                                                                    .red,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
