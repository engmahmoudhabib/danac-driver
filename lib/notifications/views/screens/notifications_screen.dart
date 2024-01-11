import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/home/controllers/home_controller.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        backgroundColor: Colors.white,
     
        title: Text(
          'notifications'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(
        () => SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              RefreshIndicator(
                onRefresh: () => controller.getNotifications(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: controller.isLoading.value == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.red,
                          ),
                        )
                      : AnimationLimiter(
                          child: ListView.separated(
                            itemCount: controller.notifications.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: ListTile(
                                      leading:
                                          Icon(Icons.notifications_outlined),
                                      title: Text(
                                        controller.notifications[index].title,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: Text(
                                        controller.notifications[index].body,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                color: Colors.black.withOpacity(0.5),
                                endIndent:
                                    MediaQuery.of(context).size.width * 0.05,
                                indent:
                                    MediaQuery.of(context).size.width * 0.05,
                              );
                            },
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
