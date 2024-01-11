// ignore_for_file: unused_field, must_be_immutable
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/core/images.dart';

class NavigationScreen extends StatelessWidget {
  double lat;
  double long;
  double sourceLat;
  double sourceLng;
  NavigationScreen({
    super.key,
    required this.lat,
    required this.long,
    required this.sourceLat,
    required this.sourceLng,
  });

  void startNavigation() async {
    final directions = MapBoxNavigation();
    final routeOptions = MapBoxOptions(
      initialLatitude: sourceLat,
      initialLongitude: sourceLng,
      zoom: 16.0,
      tilt: 0.0,
      bearing: 0.0,
      enableRefresh: false,
      alternatives: true,
      voiceInstructionsEnabled: true,
      bannerInstructionsEnabled: true,
      allowsUTurnAtWayPoints: true,
      mode: MapBoxNavigationMode.drivingWithTraffic,
      mapStyleUrlDay: 'mapbox://styles/mapbox/streets-v9/',
    );
    directions.setDefaultOptions(routeOptions);
    await directions.startNavigation(
      wayPoints: [
        WayPoint(
          name: "Origin",
          latitude: sourceLat,
          longitude: sourceLng,
        ),
        WayPoint(
          name: "Destination",
          latitude: lat,
          longitude: long,
        ),
      ],
      options: MapBoxOptions(
        mode: MapBoxNavigationMode.drivingWithTraffic,
        simulateRoute: true,
        language: Get.locale!.languageCode,
        units: VoiceUnits.imperial,
        allowsUTurnAtWayPoints: true,
        animateBuildRoute: true,
        alternatives: true,
        bannerInstructionsEnabled: true,
        enableRefresh: true,
        isOptimized: true,
        showEndOfRouteFeedback: true,
      ),
    );
  }

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
          'follow_order'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FadeInLeft(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Image.asset(AppImages.mapman),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    startNavigation();
                  },
                  child: Text(
                    'follow_order_on_map'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
            ],
          ),
        ),
      ),
    );
  }
}

