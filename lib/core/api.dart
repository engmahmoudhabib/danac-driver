class API {
  API._();

  static final _baseURL = 'your_url';
  static final loginURL = _baseURL + 'auth/log-in/';
  static final signUpURL = _baseURL + 'auth/sign-up/';
  static final categoriesURL = _baseURL + 'categories/';
  static final productsURL = _baseURL + 'products/';
  static final deleteProductsURL = _baseURL + 'get-product/';
  static final refreshTokenURL = _baseURL + 'token/refresh/';
  static final suppliersURL = _baseURL + 'suppliers/';
  static final updateSupplier = _baseURL + 'get-supplier/';
  static final clientsURL = _baseURL + 'clients/';
  static final deleteClientsURL = _baseURL + 'get-client/';
  static final createMediumURL = _baseURL + 'create-medium/';
  static final addToMediumURL = _baseURL + 'add-to-medium/';
  static final getMediumTable = _baseURL + 'list-medium-products/';
  static final addItem = _baseURL + 'medium-handler-quantity/';
  static final createIncomeURL = _baseURL + 'create-incoming/';
  static final getIncomeListURL = _baseURL + 'list-incoming';
  static final getOTPURL = _baseURL + 'get-code/';
  static final sendOTPURL = _baseURL + 'verify-code-password/';
  static final acticateAccountOTP = _baseURL + 'verefy-code/';
  static final resetPasswordURL = _baseURL + 'auth/reset-password/';
  static final updateProfile = _baseURL + 'settings/update-image/';
  static final getSpecialProductsURL = _baseURL + 'special-products/';
  static final createCartURL = _baseURL + 'cart/';
  static final addToCartURL = _baseURL + 'add_to_cart/';
  static final cartItemsURL = _baseURL + 'cart_items/';
  static final changeQuantityURL = _baseURL + 'change-quantity/';
  static final addOrderURL = _baseURL + 'create-order/';
  static final getOrdersURL = _baseURL + 'client-orders/';
  static final getOrderURL = _baseURL + 'order/';
  static final getDriverOrderURL = _baseURL + 'get/';
  static final pointsURL = _baseURL + 'total-points/';
  static final usedPointsURL = _baseURL + 'used-points/';
  static final expiredPointsURL = _baseURL + 'expired-points/';
  static final deleteItemFromCartURL = _baseURL + 'delete-item/';
  static final addOrderMedium2URL = _baseURL + 'create-order-envoy/';
  static final createMedium2URL = _baseURL + 'create-medium-two/';
  static final addToMedium2URL = _baseURL + 'add-to-medium-two/';
  static final medium2ListURL = _baseURL + 'list-medium-two-products/';
  static final addSubMedium2URL = _baseURL + 'medium-two-handler/';
  static final deleteFromMedium2URL =
      _baseURL + 'delete-product-from-medium-two/';
  static final driverOrdersURL =
      _baseURL + 'get-delivery-arrived-for-employee/';
  static final notificationsURL = _baseURL+'notifications';
   static final updateLocationURL = _baseURL+'update-location/';
}
