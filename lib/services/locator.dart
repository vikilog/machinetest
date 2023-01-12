import 'package:get_it/get_it.dart';
import 'package:machinetest/services/api.dart';
import 'package:machinetest/services/auth.dart';
import 'package:machinetest/services/category.dart';
import 'package:machinetest/services/product.dart';

import 'navigation.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => CategoryService());
  locator.registerLazySingleton(() => ProductService());
  locator.registerLazySingleton(() => Auth());
}
