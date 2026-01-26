import 'dart:convert';
import 'package:gap/gap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viral_bites/core/common/widgets/custom_button.dart';
import 'package:viral_bites/core/models/product_model.dart';
import 'package:viral_bites/core/services/api_service.dart';
import 'package:viral_bites/core/services/storage_service.dart';
import 'package:viral_bites/core/utils/constants/app_urls.dart';
import 'package:viral_bites/feature/auth/screen/sign_in_screen.dart';
import 'package:viral_bites/feature/home/screen/product_screen.dart';
import '../../../core/utils/constants/app_colors.dart';

class HomeScreenController extends GetxController {
  var isLoading = true.obs;
  var products = <Product>[].obs;
  Product? selectedProduct;
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDesController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productRatingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void getUserProfile() async {
    final String authToken = await StorageService().getData('authToken');
    if (authToken.isEmpty) {
      if (kDebugMode) {
        print('auth token not found');
      }
      return;
    }
    try {
      isLoading.value = true;
      final response = await ApiService().getRequest(
        AppUrls.getUser,
        authToken,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        showUserProfilePopup(data['data']);
        if (kDebugMode) {
          print(response.body);
          print('authToken is $authToken');
        }
      } else {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void showUserProfilePopup(Map<String, dynamic> data) {
    dynamic id = data['id'];
    dynamic name = data['fullName'];
    String email = data['email'];
    String phoneNumber = data['phoneNumber'];
    String joined = data['createdAt'];

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.textWhite,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: [
              Text('ID: $id'),
              Text('Name: $name'),
              Text('Email: $email'),
              Text('Phone: $phoneNumber'),
              Text("Joined: $joined"),
            ],
          ),
        ),
      ),
    );
  }

  void fetchProducts() async {
    try {
      final result = await ApiService().fetchProducts();
      products.assignAll(result);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void logout() async {
    await StorageService().removeData('authToken');
    Get.offAll(() => SignInScreen());
  }

  void getSingleProduct(Product product) async {
    try {
      final result = await ApiService().getSingleProduct(product.name);
      selectedProduct = result;
      Get.to(() => ProductScreen());
    // ignore: empty_catches
    } catch (e) {}
  }

  void deleteProduct(String? id) async {
    final String authToken = await StorageService().getData('authToken');
    if (authToken.isEmpty) {
      if (kDebugMode) {
        print('auth token not found');
      }
      return;
    }
    try {
      final response = await ApiService().deleteProduct(id, authToken);
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success!',
          'Deleted Success, please refresh the product list.',
        );
      } else {
        Get.snackbar('Delete Failed', 'Status code: ${response.statusCode}');
      }
      if (kDebugMode) {
        print(response);
      }
    // ignore: empty_catches
    } catch (e) {}
  }

  void editProduct(String? id) async {
    final name = productNameController.text.trim();
    final des = productDesController.text.trim();
    final price = productPriceController.text.trim();
    final rating = productRatingController.text.trim();
    final String authToken = await StorageService().getData('authToken');

    try {
      final response = await ApiService().editProduct(
        id,
        authToken,
        name,
        des,
        price,
        rating,
      );
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar('Suceess!', 'Product info Edited successfully!');
      } else {
        Get.back();
        Get.snackbar('Error!', 'Product edit failed');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void showEditDialogue(String? id) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.textWhite,
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
        child: Padding(
          padding: .all(16),
          child: Column(
            mainAxisSize: .min,
            children: [
              TextField(
                controller: productNameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              Gap(5),
              TextField(
                controller: productDesController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              Gap(5),
              TextField(
                controller: productPriceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              Gap(5),
              TextField(
                controller: productRatingController,
                decoration: InputDecoration(labelText: 'Rating'),
              ),
              Gap(5),
              CustomButton(text: 'Submit', onPressed: () => editProduct(id)),
            ],
          ),
        ),
      ),
    );
  }


  
}
