import 'package:machinetest/model/categorymodel.dart';
import 'package:machinetest/provider/baseprovider.dart';
import 'package:machinetest/services/category.dart';
import 'package:machinetest/services/locator.dart';

class CategoryProvider extends BaseProvider {
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  void setCategories(List<CategoryModel> categories) {
    _categories = categories;
    notifyListeners();
  }

  loadCategories() async {
    try {
      var categories = await locator<CategoryService>().getCategories();
      setCategories(categories);
      setErrorMessage('');
    } catch (e) {
      setErrorMessage(e.toString());
    }
    setBusy(false);
  }
}
