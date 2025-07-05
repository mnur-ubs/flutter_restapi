import 'package:flutter/material.dart';
import 'package:flutter_restapi/controller/product_controller.dart';
import 'package:flutter_restapi/login.dart';
import 'package:flutter_restapi/products.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; 

void main() {
  GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
     return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      getPages: [
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/products", page: () => ProductPage())
      ],
     );
  }
}
