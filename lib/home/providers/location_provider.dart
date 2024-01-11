import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/home/models/update_location_response_model.dart';

class LocationProvider extends GetConnect {
  Future<Either<UpdateLocarionResponseModel, String?>> updateLocation(
      double lat, double lng) async {
    try {
      final response = await put(
        API.updateLocationURL ,
        {"x": lng, "y": lat},
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );

      if (response.status.isOk) {
        return Left(UpdateLocarionResponseModel.fromJson(response.body));
      } else {
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }
}
