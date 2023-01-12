import 'dart:convert';
import 'package:machinetest/const/urls.dart';
import 'package:machinetest/model/productmodel.dart';
import 'package:machinetest/services/api.dart';
import 'package:machinetest/services/locator.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<ProductModel>> getProducts(int skip, int limit) async {
    try {
      http.Response response = await locator<ApiService>()
          .get('${Apiendpoints.PRODUCT}?skip=${skip * limit}&limit=$limit');
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List<ProductModel> products = [];
        for (var item in jsonData['products']) {
          products.add(ProductModel.fromJson(item));
        }
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ProductModel> getProductDetails(int id) async {
    try {
      http.Response response =
          await locator<ApiService>().get('${Apiendpoints.PRODUCT}/$id');
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        ProductModel product = ProductModel.fromJson(jsonData);
        return product;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ProductModel>> getProductByCategory(
      String categoryName, page, limit) async {
    try {
      http.Response response = await locator<ApiService>().get(
          '${Apiendpoints.PRODUCT_BY_CATEGORY}/$categoryName?skip=${page * limit}&limit=$limit');
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List<ProductModel> products = [];
        for (var item in jsonData['products']) {
          products.add(ProductModel.fromJson(item));
        }
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ProductModel>> searchProduct(String query) async {
    try {
      http.Response response =
          await locator<ApiService>().get('${Apiendpoints.SEARCH}?q=$query');
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List<ProductModel> products = [];
        for (var item in jsonData['products']) {
          products.add(ProductModel.fromJson(item));
        }
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
