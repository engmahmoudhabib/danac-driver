import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/home/models/get_driver_order_model.dart';
import 'package:storeapp/home/models/order_response_model.dart';
import 'package:storeapp/home/models/orders_response_model.dart';

class OrderProvider extends GetConnect {
  Future<Either<List<OrdersResponseModel>, String?>> getOrders() async {
    try {
      final response = await get(
        API.getOrdersURL,
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        Iterable l = response.body;
        List<OrdersResponseModel> res = List<OrdersResponseModel>.from(
            l.map((model) => OrdersResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<OrderResponseModel, String?>> getOrder(id) async {
    try {
      final response = await get(
        API.getOrderURL + '$id/',
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        return Left(OrderResponseModel.fromJson(response.body));
      } else {
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  Future<Either<GetDriverOrderResponseModel, String?>> getDriverOrder(
      id) async {
    try {
      final response = await get(
        API.getDriverOrderURL + '$id/',
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
       
        return Left(GetDriverOrderResponseModel.fromJson(response.body));
      } else {
       
        return Right(response.body);
      }
    } catch (e) {
  
      return Right(e.toString());
    }
  }
}
