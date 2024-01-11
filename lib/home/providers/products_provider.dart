import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/home/models/products_categories_response_model.dart';
import 'package:storeapp/home/models/search_products_response_model.dart';
import 'package:storeapp/home/models/special_products_response_model.dart';

class ProductsProvider extends GetConnect {
  Future<Either<List<SpecialProductsResponseModel>, String?>>
      getSpecialProducts() async {
    try {
      final response = await get(
        API.getSpecialProductsURL,
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        Iterable l = response.body;

        List<SpecialProductsResponseModel> res =
            List<SpecialProductsResponseModel>.from(
                l.map((model) => SpecialProductsResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<List<SearchlProductsResponseModel>, String?>>
      getProductsByNameOrBarcode(name, bool isBarcode) async {
    try {
      final response = await get(
        isBarcode
            ? API.productsURL + '?barcode=$name'
            : API.productsURL + '?name=$name',
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        Iterable l = response.body;
        List<SearchlProductsResponseModel> res =
            List<SearchlProductsResponseModel>.from(
                l.map((model) => SearchlProductsResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<List<SearchlProductsResponseModel>, String?>>
      getProductsByCategory(String type) async {
    try {
      final response = await get(
        API.productsURL + '?category=$type',
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        Iterable l = response.body;
        List<SearchlProductsResponseModel> res =
            List<SearchlProductsResponseModel>.from(
                l.map((model) => SearchlProductsResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<List<ProductsCategoriesResponseModel>, String?>>
      getProductsCategories() async {
    try {
      final response = await get(
        API.categoriesURL,
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        Iterable l = response.body;
        List<ProductsCategoriesResponseModel> res =
            List<ProductsCategoriesResponseModel>.from(l.map(
                (model) => ProductsCategoriesResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }
}
