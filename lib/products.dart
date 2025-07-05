import 'package:flutter/material.dart';
import 'package:flutter_restapi/controller/product_controller.dart';
import 'package:get/get.dart'; 

class ProductPage extends StatelessWidget {
  ProductPage({super.key});
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    controller.fetchProducts();
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return ListTile(
              leading: Image.network(product.thumbnail),
              title: Text(product.title),
              subtitle: Text('\$${product.price}'),
            );
          },
        );
      }),
    );
  }
}