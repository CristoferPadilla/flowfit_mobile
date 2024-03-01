import 'dart:convert';
import 'package:flowfit_mobile/features/shop/widgets/card/custome_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Product {
  final String name;
  final String description;
  final String price;
  final String imagePath;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}

class GridViewShop extends StatefulWidget {
  const GridViewShop({Key? key}) : super(key: key);

  @override
  _GridViewShopState createState() => _GridViewShopState();
}

class _GridViewShopState extends State<GridViewShop> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String accessToken = prefs.getString('accessToken') ?? '';

    final response = await http.get(
      Uri.parse('https://api-zydf.onrender.com/products'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        products = data.map((item) {
          return Product(
            name: item['name'],
            description: item['description'],
            price: item['price'].toString(),
            imagePath: item['image_path'],
          );
        }).toList();
      });
    } else {
       Text('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.65,
      width: double.infinity,
      child: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.66,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return CustomCard(
                  name: product.name,
                  description: product.description,
                  price: product.price,
                  imagePath: product.imagePath,
                );
              },
            ),
    );
  }
}
