import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:machinetest/pages/product_by_category.dart';
import 'package:machinetest/provider/category.dart';
import 'package:machinetest/services/locator.dart';
import 'package:machinetest/services/navigation.dart';
import 'package:machinetest/widgets/appbar.dart';
import 'package:machinetest/widgets/loading.dart';
import 'package:provider/provider.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({super.key});

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  @override
  void initState() {
    loadCategories();
    super.initState();
  }

  void loadCategories() async {
    await Provider.of<CategoryProvider>(context, listen: false)
        .loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, value, child) {
        return Scaffold(
            appBar: CustomAppBar(title: 'Category'),
            body: value.hasErrorMessage
                ? Center(
                    child: Text(value.errorMessage),
                  )
                : LoadingOverlay(
                    isLoading: value.busy,
                    progressIndicator: const Loading(),
                    color: Colors.white,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: value.categories.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => locator<NavigationService>()
                              .navigateWithChild(ProductByCatehory(
                                  category: value.categories[index].name)),
                          child: Card(
                            child: Center(
                                child: Text(
                              value.categories[index].name.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            )),
                          ),
                        );
                      },
                    ),
                  ));
      },
    );
  }
}
