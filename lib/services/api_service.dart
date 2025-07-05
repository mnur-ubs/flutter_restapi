import 'package:flutter_restapi/model/product_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApiService extends GetConnect {
  @override
  final baseUrl = "http://10.0.2.2:3000";
  final box = GetStorage();

  @override
  void onInit() {
    httpClient.baseUrl = baseUrl;
    httpClient.addRequestModifier<Object?>((request) {
      final accessToken = box.read("access_token");
      if (accessToken != null) {
        request.headers["Authorization"] = "Bearer $accessToken";
      }
      return request;
    },);

    httpClient.addResponseModifier((request, response) {
    if (response.statusCode == 401) {
      // Token expired or unauthorized
      GetStorage().remove('access_token');
      Get.offAllNamed('/login');
    }
    return response;
  });
  }

  Future<bool> login(String email, String password) async {
    final response = await post("/login", { "email": email, "password": password});
    if (response.statusCode == 200) {
      final accessToken = response.body["access_token"];
      print(accessToken);
      box.write("access_token", accessToken);
      return true;
    }
    return false;
  }

  void logout() {
    box.remove("access_token");
  }

  Future<List<Product>> fetchProducts() async {
    final accessToken = box.read("access_token");
    final response = await get('/products', headers: { "Authorization": "Bearer $accessToken"});
    print("Response from API:");
    print(response.statusText);
    if (response.status.hasError) {
      throw Exception('Failed to load products');
    }

    final List<dynamic> rawList = response.body['data'];
    return rawList.map((json) => Product.fromJson(json)).toList();
  }
}