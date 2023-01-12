import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/model/productmodel.dart';
import 'package:machinetest/provider/product.dart';
import 'package:machinetest/services/locator.dart';
import 'package:machinetest/services/product.dart';
import 'package:machinetest/widgets/appbar.dart';
import 'package:machinetest/widgets/loading.dart';
import 'package:machinetest/widgets/product.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  int limit = 30;

  final ScrollController _scrollController = ScrollController();

  loadProduct() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .loadAllProducts(_page, limit);
  }

  String query = '';

  List<ProductModel> _searchProductList = [];
  bool search = false;

  searchProduct(String query) async {
    var data = await locator<ProductService>().searchProduct(query);
    setState(() {
      _searchProductList = data;
    });
  }

  @override
  void initState() {
    loadProduct();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent - 200) {
        setState(() {
          _page++;
          loadProduct();
        });
      }
    });
    super.initState();
  }

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Home',
            actions: [
              AnimSearchBar(
                color: Colors.transparent,
                boxShadow: false,
                searchIconColor: Colors.white,
                closeSearchOnSuffixTap: true,
                rtl: true,
                width: MediaQuery.of(context).size.width,
                onSubmitted: (query) {
                  setState(() {
                    search = true;
                    searchProduct(query);
                  });
                },
                textController: textController,
                onSuffixTap: () {
                  setState(() {
                    textController.clear();
                    search = false;
                  });
                },
              )
            ],
          ),
          body: value.hasErrorMessage
              ? Center(child: Text(value.errorMessage))
              : value.busy
                  ? const Center(
                      child: Loading(),
                    )
                  : search && _searchProductList.isEmpty
                      ? const Center(
                          child: Text('No Product Found'),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: search
                              ? _searchProductList.length
                              : value.products.length,
                          itemBuilder: ((context, index) {
                            var product = search
                                ? _searchProductList[index]
                                : value.products[index];
                            return ProductCard(product: product);
                          })),
        );
      },
    );
  }
}
