import 'package:flutter/material.dart';
import 'package:flutter_restapi/controller/product_controller.dart';
import 'package:flutter_restapi/products.dart';
import 'package:get/get.dart'; 

class LoginPage extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Please log in", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Obx(() => ElevatedButton(
                  onPressed: controller.isLoggedIn.value
                      ? null
                      : () async {
                          final email = emailController.text;
                          final password = passwordController.text;

                          await controller.login(email, password);
                          if (controller.isLoggedIn.value) {
                            Get.offAll(() => ProductPage()); // redirect
                          }
                        },
                  child: const Text('Login'),
                )),
          ],
        ),
      ),
    );
  }
}
