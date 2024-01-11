// ignore_for_file: unused_local_variable
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/home/models/cart_item_response_model.dart';
import 'package:storeapp/home/models/get_driver_order_model.dart';
import 'package:storeapp/home/models/get_order_list_driver_response_model.dart';
import 'package:storeapp/home/models/medium_two_response_model.dart';
import 'package:storeapp/home/models/notifications_response_model.dart';
import 'package:storeapp/home/models/order_response_model.dart';
import 'package:storeapp/home/models/orders_response_model.dart';
import 'package:storeapp/home/models/points_response_model.dart';
import 'package:storeapp/home/models/products_categories_response_model.dart';
import 'package:storeapp/home/models/search_products_response_model.dart';
import 'package:storeapp/home/models/special_products_response_model.dart';
import 'package:storeapp/home/providers/cart_provider.dart';
import 'package:storeapp/home/providers/notifications_provider.dart';
import 'package:storeapp/home/providers/orders_provider.dart';
import 'package:storeapp/home/providers/points_provider.dart';
import 'package:storeapp/home/providers/products_provider.dart';
import 'package:storeapp/home/providers/profile_provider.dart';
import 'package:storeapp/home/views/screens/agent_home_screen.dart';
import 'package:storeapp/home/views/screens/agent_products_screen.dart';
import 'package:storeapp/home/views/screens/home_screen.dart';
import 'package:storeapp/home/views/screens/navigation_screen.dart';
import 'package:storeapp/home/views/widgets/add_to_cart_successfuly_dialog.dart';
import 'package:storeapp/home/views/widgets/order_success_dialog.dart';
import 'package:storeapp/notifications/views/screens/notifications_screen.dart';
import 'package:storeapp/settings/views/screens/settings_screen.dart';
import 'package:geocoder2/geocoder2.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late PersistentTabController controller;
  RxBool isLoading = false.obs;
  RxBool isLoadingSearch = false.obs;
  RxBool isAddingToCart = false.obs;
  RxInt cartId = 0.obs;
  RxBool isGettingLocation = false.obs;
  RxDouble cartItemsTotalPrice = 0.0.obs;
  RxString date = DateTime.now()
      .toString()
      .substring(0, DateTime.now().toString().indexOf(' '))
      .obs;
  TextEditingController? searchController = TextEditingController();
  TextEditingController? clientNameController = TextEditingController();
  TextEditingController? clientPhoneController = TextEditingController();
  TextEditingController? clientAddressController = TextEditingController();
  RxList specialProducts = <SpecialProductsResponseModel>[].obs;
  RxList allProducts = <SearchlProductsResponseModel>[].obs;
  RxList searchProducts = <SearchlProductsResponseModel>[].obs;
  RxList cartItems = <GetCartItemsResponseModel>[].obs;
  RxList cartMedium2Items = <MediumTwoResponseModel>[].obs;
  RxList orders = <OrdersResponseModel>[].obs;
  RxList notifications = <NotificationsResponseModel>[].obs;
  RxList driverOrders = <GetDriverOrdersListResponseModel>[].obs;
  RxList points = <PointsResponseModel>[].obs;
  final ProductsProvider _productsProvider = ProductsProvider();
  final CartProvider _cartProvider = CartProvider();
  final OrderProvider _orderProvider = OrderProvider();
  final PointsProvider _pointsProvider = PointsProvider();
  final ProfileProvider _profileProvider = ProfileProvider();
  final NotificationsProvider _notificationsProvider = NotificationsProvider();
  RxList order = <OrderResponseModel>[].obs;
  RxList productsCategories = <ProductsCategoriesResponseModel>[].obs;
  RxList driverOrder = <GetDriverOrderResponseModel>[].obs;
  late Completer<GoogleMapController> googleMapsController = Completer();
  var destination = "".obs;
  var distanceLeft = "".obs;
  var timeLeft = "".obs;
  var mapStatus = "".obs;
  var arrived = true.obs;
  var gettingRoute = false.obs;
  XFile? image;
  RxInt medium2Id = 0.obs;
  var markers = <MarkerId, Marker>{}.obs;
  List<LatLng> polylineCoordinates = <LatLng>[].obs;
  Set<Polyline> polyline = <Polyline>{}.obs;
  Animation<double>? animation;
  LatLng destinationCoordinates = const LatLng(0, 0);

  removeImage(refresh) {
    image = null;
    refresh();
    Navigator.pop(Get.overlayContext!, true);
  }

  Future pickImageFromGallery(refresh) async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = XFile(img!.path);
    refresh();
    Navigator.pop(Get.overlayContext!, true);
  }

  Future pickImageFromCamera(refresh) async {
    final img = await ImagePicker().pickImage(source: ImageSource.camera);
    image = XFile(img!.path);
    refresh();
    Navigator.pop(Get.overlayContext!, true);
  }

  updateProfile(context) async {
    if (image != null) {
      Uint8List? compressedFile =
          await FlutterImageCompress.compressWithFile(image!.path, quality: 90);
      isLoading.value = true;
      final response = await _profileProvider.updateProfile(
          compressedFile!, GetStorage().read('id').toString());
      if (response.isLeft()) {
        final result = response.fold((l) => l, (r) => null);
        GetStorage().write('image', result?.image?.image);
        Get.defaultDialog(
          title: '',
          content: Text(
            'profile_updated'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
        Phoenix.rebirth(context);
      } else if (response.isRight()) {
        Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }
      isLoading.value = false;
    } else {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'image_empty'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
  }

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  getSpecialProducts() async {
    isLoading.value = true;
    final response = await _productsProvider.getSpecialProducts();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      specialProducts.clear();
      specialProducts.addAll(result!);
      specialProducts.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoading.value = false;
  }

  getNotifications() async {
    isLoading.value = true;
    final response = await _notificationsProvider.getNotifications();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      notifications.clear();
      notifications.addAll(result!);
      notifications.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoading.value = false;
  }

  getSearchProducts(bool isBarcode) async {
    isLoadingSearch.value = true;
    final response = await _productsProvider.getProductsByNameOrBarcode(
        searchController?.text, isBarcode);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      searchProducts.clear();
      searchProducts.addAll(result!);
      searchProducts.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoadingSearch.value = false;
  }

  addToCart(context, product) async {
    isAddingToCart.value = true;
    final response =
        await _cartProvider.addToCart(GetStorage().read('id'), product);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      cartId.value = result!.cart!;

      addToCartSuccessDialog(context);
      getCartItems();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isAddingToCart.value = false;
  }

  addOrder(context) async {
    isLoading.value = true;

    final response = await _cartProvider.addOrder(cartId.value, date.value);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      Navigator.pop(Get.overlayContext!, true);
      getOrders();
      orderSuccessDialog(context);
      date.value = DateTime.now()
          .toString()
          .substring(0, DateTime.now().toString().indexOf(' '));
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  addOrderToMediumTwo(
    context,
  ) async {
    isLoading.value = true;

    final response = await _cartProvider.addOrderToMediumTwo(
        medium2Id.value,
        date.value,
        clientAddressController?.text,
        clientPhoneController?.text,
        clientNameController?.text);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      Navigator.pop(Get.overlayContext!, true);
      orderSuccessDialog(context);
      date.value = DateTime.now()
          .toString()
          .substring(0, DateTime.now().toString().indexOf(' '));
      clientAddressController?.clear();
      clientPhoneController?.clear();
      clientNameController?.clear();
      createMedium2();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  getCartItems() async {
    isLoading.value = true;
    final response = await _cartProvider.getCartItems(cartId.value);
    if (response.isLeft()) {
      cartItemsTotalPrice.value = 0.0;
      final result = response.fold((l) => l, (r) => null);
      cartItems.clear();
      cartItems.addAll(result!);
      cartItems.refresh();
      cartItems.forEach((element) {
        cartItemsTotalPrice.value =
            cartItemsTotalPrice.value + element.totalPriceOfItem;
      });
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoading.value = false;
  }

  addSub(bool isAdd, cartListID) async {
    isLoading.value = true;
    final response = await _cartProvider.changeQuantity(isAdd, cartListID);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      getCartItems();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoading.value = false;
  }

  getProductsByCategory(String type) async {
    isLoading.value = true;
    final response = await _productsProvider.getProductsByCategory(type);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      allProducts.clear();
      allProducts.addAll(result!);
      allProducts.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoading.value = false;
  }

  getOrder(id) async {
    isLoading.value = true;
    final response = await _orderProvider.getOrder(id);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      order.clear();
      order.add(result!);
      order.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  getDriverOrder(id) async {
    isLoading.value = true;
    final response = await _orderProvider.getDriverOrder(id);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);

      driverOrder.clear();
      driverOrder.add(result!);
      driverOrder.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  getMyPoints() async {
    isLoading.value = true;
    final response = await _pointsProvider.getPoints();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      points.clear();
      points.addAll(result!);
      points.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  getUsedPoints() async {
    isLoading.value = true;
    final response = await _pointsProvider.getUsedPoints();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      points.clear();
      points.addAll(result!);
      points.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  getExpiredPoints() async {
    isLoading.value = true;
    final response = await _pointsProvider.getExpiredPoints();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      points.clear();
      points.addAll(result!);
      points.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  getOrders() async {
    final response = await _orderProvider.getOrders();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      orders.clear();
      orders.addAll(result!);
      orders.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
  }

  getDriverOrders(oldOrNew) async {
    isLoading.value = true;
    final response = await _pointsProvider.getDriverOrders(oldOrNew);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      driverOrders.clear();
      driverOrders.addAll(result!);
      driverOrders.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  List<Widget> buildScreens() {
    return GetStorage().read('env') == 'agent' ||
            GetStorage().read('env') == 'proxy'
        ? [
            AgentHomeScreen(),
            AgentProductsScreen(),
            NotificationsScreen(),
            SettingsScreen(),
          ]
        : [
            GetStorage().read('env') == 'driver'
                ? AgentHomeScreen()
                : HomeScreen(),
            NotificationsScreen(),
            SettingsScreen(),
          ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return GetStorage().read('env') == 'agent' ||
            GetStorage().read('env') == 'proxy'
        ? [
            PersistentBottomNavBarItem(
              icon: Icon(Icons.home),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.add_box_outlined),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.notifications),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(GetStorage().read('env') == 'driver'
                  ? Icons.settings
                  : Icons.person),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
          ]
        : [
            PersistentBottomNavBarItem(
              icon: Icon(Icons.home),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.notifications),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.settings),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
          ];
  }

  getProductsCategories() async {
    isLoading.value = true;
    final response = await _productsProvider.getProductsCategories();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      productsCategories.clear();
      productsCategories.addAll(result!);
      productsCategories.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  createMedium2() async {
    isAddingToCart.value = true;
    final response = await _cartProvider.createMedium2();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      medium2Id.value = result!.id!;
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isAddingToCart.value = false;
  }

  addToMedium2(context, product) async {
    isAddingToCart.value = true;
    final response = await _cartProvider.addToMedium2(medium2Id.value, product);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      getCartMediumTwoItems();
      addToCartSuccessDialog(context);
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isAddingToCart.value = false;
  }

  getCartMediumTwoItems() async {
    isLoading.value = true;
    final response = await _cartProvider.getMediumTwoItems(medium2Id.value);
    if (response.isLeft()) {
      cartItemsTotalPrice.value = 0.0;
      final result = response.fold((l) => l, (r) => null);
      cartMedium2Items.clear();
      cartMedium2Items.addAll(result!);
      cartMedium2Items.refresh();
      cartMedium2Items.forEach((element) {
        cartItemsTotalPrice.value =
            cartItemsTotalPrice.value + (element.salePrice * element.quantity);
      });
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoading.value = false;
  }

  addSubMediumTwo(bool isAdd, cartListID) async {
    isLoading.value = true;
    final response =
        await _cartProvider.changeQuantityMediumTwo(isAdd, cartListID);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      getCartMediumTwoItems();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    controller = PersistentTabController(initialIndex: 0);
    getNotifications();
    getProductsCategories();
    if (GetStorage().read('env') == 'agent') {
      getSpecialProducts();

      getOrders();
      getMyPoints();
    } else if (GetStorage().read('env') == 'driver' ||
        GetStorage().read('env') == 'proxy') {
      getDriverOrders("True");

      createMedium2();
    }

    super.onInit();
  }

  deleteProduct(id) async {
    isLoading.value = true;
    final response = await _cartProvider.deleteProduct(id);
    if (response.isLeft()) {
      getCartItems();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  deleteProductFromMediumTwo(id) async {
    isLoading.value = true;
    final response = await _cartProvider.deleteProductFromMedium2(id);
    if (response.isLeft()) {
      getCartMediumTwoItems();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }
}
