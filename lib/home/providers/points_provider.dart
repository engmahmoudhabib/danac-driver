import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/home/models/get_order_list_driver_response_model.dart';
import 'package:storeapp/home/models/points_response_model.dart';

class PointsProvider extends GetConnect {
  Future<Either<List<PointsResponseModel>, String?>> getPoints() async {
    try {
      final response = await get(
        API.pointsURL,
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        Iterable l = response.body;

        List<PointsResponseModel> res = List<PointsResponseModel>.from(
            l.map((model) => PointsResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<List<PointsResponseModel>, String?>> getUsedPoints() async {
    try {
      final response = await get(
        API.usedPointsURL,
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        Iterable l = response.body;

        List<PointsResponseModel> res = List<PointsResponseModel>.from(
            l.map((model) => PointsResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<List<PointsResponseModel>, String?>> getExpiredPoints() async {
    try {
      final response = await get(
        API.expiredPointsURL,
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        Iterable l = response.body;

        List<PointsResponseModel> res = List<PointsResponseModel>.from(
            l.map((model) => PointsResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<List<GetDriverOrdersListResponseModel>, String?>>
      getDriverOrders(oldOrNew) async {
    try {
      final response = await get(
        API.driverOrdersURL + '$oldOrNew/',
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        Iterable l = response.body;

        List<GetDriverOrdersListResponseModel> res =
            List<GetDriverOrdersListResponseModel>.from(l.map(
                (model) => GetDriverOrdersListResponseModel.fromJson(model)));
        return Left(res);
      } else {
       
        return Right(response.statusText);
      }
    } catch (e) {
      
      return Right('An error occurred: $e');
    }
  }
}
