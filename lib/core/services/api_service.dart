import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:viral_bites/core/models/product_model.dart';
import 'package:viral_bites/core/utils/constants/app_urls.dart';

class ApiService {
  Future<http.Response> postRequest(
    String url,
    Map<String, dynamic> data,
  ) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  Future<http.Response> getRequest(String url, String token) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        // 'Content-Type': 'application/json',
        // 'Accept': 'application/json',
      },
    );
    return response;
  }

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrls.getProducts),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        return body['data']
            .map((item) => Product.fromJson(item))
            .toList()
            .cast<Product>();
      } else {
        throw "Failed to load products: ${response.statusCode}";
      }
    } catch (e) {
      throw "An error occurred: $e";
    }
  }

  Future<Product> getSingleProduct(String name) async {
    try {
      final response = await http.get(
        Uri.parse('${AppUrls.singleProduct}$name'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        return Product.fromJson(body['data']);
      } else {
        throw "Failed to load product: ${response.statusCode}";
      }
    } catch (e) {
      throw "An error occurred: $e";
    }
  }

  Future<http.Response> deleteProduct(String? id, String token) async {
    final response = await http.delete(
      Uri.parse('${AppUrls.singleProduct}$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Delete Successful');
    } else {
      Get.snackbar("Error!", 'Delete failed!');
    }
    return response;
  }

  Future<http.Response> editProduct(
    String? id,
    String token,
    String name,
    String des,
    String price,
    String rating,
  ) async {
    final response = await http.put(
      Uri.parse('${AppUrls.singleProduct}$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name": name,
        "description": des,
        "price": price,
        "rating": rating,
      }),
    );
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('success');
      }
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
    return response;
  }
}
