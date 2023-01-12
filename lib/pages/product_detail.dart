import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:machinetest/model/productmodel.dart';
import 'package:machinetest/services/locator.dart';
import 'package:machinetest/services/product.dart';
import 'package:machinetest/widgets/appbar.dart';
import 'package:machinetest/widgets/loading.dart';

class ProductDetail extends StatefulWidget {
  final int id;
  const ProductDetail({super.key, required this.id});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ProductModel? productModel;
  bool loading = true;

  loadProductDetails() async {
    var data = await locator<ProductService>().getProductDetails(widget.id);
    setState(() {
      productModel = data;
      loading = false;
    });
  }

  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    loadProductDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: loading
            ? 'Loading ...'
            : "${productModel!.title} of ${productModel!.brand}",
        showBackButton: true,
      ),
      body: loading
          ? const Center(
              child: Loading(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CarouselSlider(
                      carouselController: _carouselController,
                      items: (productModel!.images).map(
                        (image) {
                          return Builder(builder: ((context) {
                            return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                ));
                          }));
                        },
                      ).toList(),
                      options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          height: MediaQuery.of(context).size.width * 0.7,
                          viewportFraction: 1,
                          aspectRatio: 16 / 9)),
                  const SizedBox(height: 10),
                  ListTile(
                    title: Text(
                      productModel!.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      productModel!.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Actual Price',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '\$ ${productModel!.price}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Offer Price',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '\$ ${calculateDiscount(productModel!)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Avilable Quantity',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${productModel!.stock}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Rating',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${productModel!.rating}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
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
