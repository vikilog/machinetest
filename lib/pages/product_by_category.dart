import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:machinetest/model/productmodel.dart';
import 'package:machinetest/widgets/appbar.dart';
import 'package:machinetest/widgets/loading.dart';
import 'package:machinetest/widgets/product.dart';

import '../services/locator.dart';
import '../services/product.dart';

class ProductByCatehory extends StatefulWidget {
  final String category;
  const ProductByCatehory({super.key, required this.category});

  @override
  State<ProductByCatehory> createState() => _ProductByCatehoryState();
}

class _ProductByCatehoryState extends State<ProductByCatehory> {
  List<ProductModel> _productList = [];

  loadProductByCategory() async {
    var data = await locator<ProductService>()
        .getProductByCategory(widget.category, page, limit);
    setState(() {
      _productList = data;
      loading = false;
    });
  }

  bool loading = true;
  int page = 0;
  int limit = 30;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    loadProductByCategory();
    if (_scrollController.hasClients) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent - 200) {
          page++;
          loadProductByCategory();
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.category.toUpperCase(),
        showBackButton: true,
      ),
      body: loading
          ? const Center(child: Loading())
          : ListView.builder(
              itemCount: _productList.length,
              itemBuilder: (context, index) {
                var product = _productList[index];
                return ProductCard(product: product);
              }),
    );
  }
}
