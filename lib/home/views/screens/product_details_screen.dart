import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/core/images.dart';
import 'package:storeapp/home/controllers/home_controller.dart';
import 'package:storeapp/home/views/screens/cart_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productName;
  final String url;
  final String details;
  final String units;
  final String cartoon;
  final String category;
  final String cartoonPrice;
  final int id;
  ProductDetailsScreen({
    super.key,
    required this.productName,
    required this.url,
    required this.details,
    required this.cartoon,
    required this.units,
    required this.category,
    required this.cartoonPrice,
    required this.id,
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
          productName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: CartScreen(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Image.asset(
              AppImages.cart,
            ),
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      url,
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
                      productName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
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
                      details,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  color: AppColors.red,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "unit".tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: ": $units",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "cartoon".tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: ": $cartoon",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(
                  color: AppColors.red,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "cat".tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ": $category",
                            style: TextStyle(
                              color: AppColors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "cartoon_price".tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ": $cartoonPrice",
                            style: TextStyle(
                              color: AppColors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FadeInLeft(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 45,
                  child: controller.isAddingToCart.value == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.red,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (GetStorage().read('env') == 'agent') {
                              controller.addToCart(context, id);
                            } else if (GetStorage().read('env') == 'proxy') {
                              controller.addToMedium2(context, id);
                            } 
                          },
                          child: Text(
                            'add_to_cart'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(AppColors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
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
        ),
      ),
    );
  }
}
