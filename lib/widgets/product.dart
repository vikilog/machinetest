import 'package:flutter/material.dart';
import 'package:machinetest/model/productmodel.dart';
import 'package:machinetest/pages/product_detail.dart';
import 'package:machinetest/services/locator.dart';
import 'package:machinetest/services/navigation.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => locator<NavigationService>()
          .navigateWithChild(ProductDetail(id: product.id)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              product.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.description,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "  \$ ${product.price}",
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "\$ ${calculateDiscount(product)}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  calculateDiscount(ProductModel product) {
    var discount = (product.price * (product.discountPercentage / 100));
    return (product.price - discount).toStringAsFixed(2);
  }
}
