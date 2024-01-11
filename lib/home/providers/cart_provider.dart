import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/home/models/add_order_response_model.dart';
import 'package:storeapp/home/models/add_to_medium_two_response_model.dart';
import 'package:storeapp/home/models/cart_item_response_model.dart';
import 'package:storeapp/home/models/create_cart_response_model.dart';
import 'package:storeapp/home/models/create_order_medium_two_response_model.dart';
import 'package:storeapp/home/models/medium_two_response_model.dart';

class CartProvider extends GetConnect {
  Future<Either<CreateCartResponseModel, String?>> addToCart(
      user, product) async {
    try {
      final response = await post(
        API.addToCartURL + '$product/$user/',
        {},
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );

      if (response.status.isOk) {
        return Left(CreateCartResponseModel.fromJson(response.body));
      } else {
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  Future<Either<CreateMediumTwoResponseModel, String?>> createMedium2() async {
    try {
      final response = await post(API.createMedium2URL, {});

      if (response.status.isOk) {
        return Left(CreateMediumTwoResponseModel.fromJson(response.body));
      } else {
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  Future<Either<AddToMediumTwoResponseModel, String?>> addToMedium2(
      mediumID, product) async {
    try {
      final response =
          await post(API.addToMedium2URL + '$mediumID/$product/', {});
      if (response.status.isOk) {
        return Left(AddToMediumTwoResponseModel.fromJson(response.body));
      } else {
        print(response.body);
        return Right(response.body);
      }
    } catch (e) {
      print(e.toString());
      return Right(e.toString());
    }
  }

  Future<Either<String?, String?>> deleteProduct(id) async {
    try {
      final response = await delete(
        API.deleteItemFromCartURL + '$id/',
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );

      if (response.status.isOk) {
        return Left('deleteed successfully');
      } else {
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  Future<Either<String?, String?>> deleteProductFromMedium2(id) async {
    try {
      final response = await delete(
        API.deleteFromMedium2URL + '$id/',
      );

      if (response.status.isOk) {
        return Left('deleteed successfully');
      } else {
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  Future<Either<CreateCartResponseModel, String?>> changeQuantity(
      bool isAdd, cartListID) async {
    try {
      final response = await post(
        isAdd
            ? API.changeQuantityURL + '$cartListID/add/'
            : API.changeQuantityURL + '$cartListID/sub/',
        {},
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );

      if (response.status.isOk) {
        return Left(CreateCartResponseModel.fromJson(response.body));
      } else {
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  Future<Either<AddOrderResponseModel, String?>> addOrder(cartID, date) async {
    try {
      final response = await post(
        API.addOrderURL + '$cartID/',
        {'delivery_date': date},
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );

      if (response.status.isOk) {
        return Left(AddOrderResponseModel.fromJson(response.body));
      } else {
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  Future<Either<CreateOrderMediumTwoResponseModel, String?>>
      addOrderToMediumTwo(mediumID, date, address, phonenumber, client) async {
    try {
      final response = await post(
        API.addOrderMedium2URL + '$mediumID/',
        {
          'delivery_date': date,
          'address': address,
          'phonenumber': phonenumber,
          'client': client,
        },
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );

      if (response.status.isOk) {
        return Left(CreateOrderMediumTwoResponseModel.fromJson(response.body));
      } else {
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  Future<Either<List<GetCartItemsResponseModel>, String?>> getCartItems(
      cart) async {
    try {
      final response = await get(
        API.cartItemsURL + '$cart',
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        Iterable l = response.body;

        List<GetCartItemsResponseModel> res =
            List<GetCartItemsResponseModel>.from(
                l.map((model) => GetCartItemsResponseModel.fromJson(model)));

        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<List<MediumTwoResponseModel>, String?>> getMediumTwoItems(
      medium2ID) async {
    try {
      final response = await get(API.medium2ListURL + '$medium2ID');
      if (response.status.isOk) {
        Iterable l = response.body;

        List<MediumTwoResponseModel> res = List<MediumTwoResponseModel>.from(
            l.map((model) => MediumTwoResponseModel.fromJson(model)));

        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<MediumTwoResponseModel, String?>> changeQuantityMediumTwo(
      bool isAdd, cartListID) async {
    try {
      final response = await post(
          isAdd
              ? API.addSubMedium2URL + '$cartListID/add/'
              : API.addSubMedium2URL + '$cartListID/sub/',
          {});

      if (response.status.isOk) {
        return Left(MediumTwoResponseModel.fromJson(response.body));
      } else {
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }
}
