import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:machinetest/const/urls.dart';
import 'package:machinetest/model/categorymodel.dart';
import 'package:machinetest/services/api.dart';
import 'package:machinetest/services/locator.dart';

class CategoryService {
  Future<List<CategoryModel>> getCategories() async {
    try {
      http.Response response =
          await locator<ApiService>().get(Apiendpoints.CATEGORY);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List<CategoryModel> categories = [];
        for (var item in jsonData) {
          categories.add(CategoryModel(name: item));
        }
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
