import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:storeapp/core/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:storeapp/sign_up/controllers/sign_up_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> markers = [];
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String? long, lat;
  late StreamSubscription<Position> positionStream;
  final SignUpController controller = Get.put(SignUpController());
  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.defaultDialog(
            title: 'error'.tr,
            content: Text(
              "Location permissions are permanently denied".tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else if (permission == LocationPermission.deniedForever) {
          Get.defaultDialog(
            title: 'error'.tr,
            content: Text(
              "Location permissions are permanently denied".tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
      if (haspermission) {
        setState(() {});

        getLocation();
      }
    } else {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          "GPS Service is not enabled, turn on GPS location".tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    setState(() {});
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long = position.longitude.toString();
    lat = position.latitude.toString();
    setState(() {});
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      long = position.longitude.toString();
      lat = position.latitude.toString();
      GetStorage().write('lat', lat);
      GetStorage().write('long', long);
   
      markers.add(
        Marker(
          width: 150.0,
          height: 150.0,
          point: latLng.LatLng(double.parse(lat!), double.parse(long!)),
          builder: (ctx) => const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 35.0,
          ),
        ),
      );
      setState(() {});
    });
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
          'd_location'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: lat == null || long == null
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.red,
              ),
            )
          : Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    center:
                        latLng.LatLng(double.parse(lat!), double.parse(long!)),
                    onTap: (position, latlng) {
                      setState(() {
                        markers.clear();
                        markers.add(
                          Marker(
                            width: 150.0,
                            height: 150.0,
                            point: latlng,
                            builder: (ctx) => const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 35.0,
                            ),
                          ),
                        );
                      });
                      GetStorage().write('lat', latlng.latitude.toString());
                      GetStorage().write('long', latlng.longitude.toString());
                     
                    },
                    zoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/mahmoudhabib/clqjpcx4v00n201o36nb8gfip/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFobW91ZGhhYmliIiwiYSI6ImNscXh6YWtiZzA0bDQycGxsOGF0dmJzc3YifQ.m-x2FCK7JR_XikXNH5RH5w',
                      additionalOptions: {
                        'accessToken':
                            'pk.eyJ1IjoibWFobW91ZGhhYmliIiwiYSI6ImNscXh6YWtiZzA0bDQycGxsOGF0dmJzc3YifQ.m-x2FCK7JR_XikXNH5RH5w',
                        'id': 'mapbox.mapbox-streets-v8',
                      },
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        for (int i = 0; i < markers.length; i++) markers[i]
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.8,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: Obx(
                    () => FadeInLeft(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 45,
                        child: controller.isLoading.value == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.red,
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  controller.signUp(context);
                                },
                                child: Text(
                                  'create_account'.tr,
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
                  ),
                ),
              ],
            ),
    );
  }
}
