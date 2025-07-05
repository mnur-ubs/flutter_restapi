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
      final accessToken = box.read<String>("access_token"); 
      if (accessToken != null) {
        request.headers["Authorization"] = "Bearer $accessToken";
      }
      return request;
    },);

    httpClient.addResponseModifier((request, response) {
    if (response.statusCode == 401) {  
      GetStorage().remove('access_token');
      Get.offAllNamed('/login');
    }
    return response;
  });
  }

  Future<bool> login(String email, String password) async {
    final response = await httpClient.post("/login", body:{ "email": email, "password": password});
    if (response.statusCode == 200) {
      final accessToken = response.body["access_token"];
      print(accessToken);
      await box.write("access_token", accessToken);
      return true;
    }
    return false;
  }

  void logout() {
    box.remove("access_token");
  }

  Future<List<Product>> fetchProducts() async { 
    final response = await httpClient.get('/products');
    print("Response from API:");
    print(response.statusText);
    if (response.status.hasError) {
      throw Exception('Failed to load products');
    }

    final List<dynamic> rawList = response.body['data'];
    return rawList.map((json) => Product.fromJson(json)).toList();
  }
}