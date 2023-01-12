import 'package:machinetest/model/productmodel.dart';
import 'package:machinetest/provider/baseprovider.dart';
import 'package:machinetest/services/locator.dart';
import 'package:machinetest/services/product.dart';

class ProductProvider extends BaseProvider {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  void setProducts(List<ProductModel> products) {
    _products = products;
  }

  loadAllProducts(int skip, int limit) async {
    try {
      var products = await locator<ProductService>().getProducts(skip, limit);
      setProducts(products);
      setErrorMessage('');
    } catch (e) {
      setErrorMessage(e.toString());
    }
    setBusy(false);
  }
}
