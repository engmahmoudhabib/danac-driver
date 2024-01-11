import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:storeapp/core/app_pages.dart';
import 'package:storeapp/core/local.dart';
import 'package:storeapp/firebase_api.dart';
import 'package:storeapp/home/providers/location_provider.dart';
import 'package:storeapp/login/views/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebasAPI().initNotifications();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  GetStorage().write('env', 'driver');
  runApp(
    Phoenix(
      child: const StoreApp(),
    ),
  );
}

class StoreApp extends StatefulWidget {
  const StoreApp({super.key});

  @override
  State<StoreApp> createState() => _StoreAppState();
}

class _StoreAppState extends State<StoreApp> {
  @override
  void initState() {
    super.initState();
    if (GetStorage().read('env') == 'driver' &&
        GetStorage().read('access') != null) {
      Location location = new Location();
      location.enableBackgroundMode(enable: true);
      location.onLocationChanged.listen((LocationData currentLocation) {
        if (currentLocation.latitude != null)
          updateLocation(currentLocation.latitude!, currentLocation.longitude!);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  final LocationProvider _locationProvider = LocationProvider();
  updateLocation(double lat, double lng) async {
    final response = await _locationProvider.updateLocation(lat, lng);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
    } else if (response.isRight()) {
   
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DANAC DRIVER',
      home: LoginScreen(),
      translations: MyLocale(),
      locale: GetStorage().read('lang') != null
          ? Locale(GetStorage().read('lang'),
              GetStorage().read('lang') == 'ar' ? 'AR' : 'FR')
          : Locale('ar', 'AR'),
      theme: ThemeData(fontFamily: 'Tajawal'),
      getPages: AppPages.routes,
      initialRoute:
          GetStorage().read('refresh') != null ? Routes.SPLASH : Routes.LOGIN,
    );
  }
}
