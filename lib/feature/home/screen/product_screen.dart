import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_screen_controller.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.showEditDialogue(controller.selectedProduct?.id);
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text(
                controller.selectedProduct?.name ?? "No product selected",
                textAlign: .center,
              ),
              Text(
                controller.selectedProduct?.description ??
                    "No product selected",
                textAlign: .center,
              ),
              Text(
                controller.selectedProduct?.id ?? "No product selected",
                textAlign: .center,
              ),
              Text(
                controller.selectedProduct?.imageUrl ?? "No product selected",
                textAlign: .center,
              ),
              Text(
                controller.selectedProduct?.slug ?? "No product selected",
                textAlign: .center,
              ),
              Text(
                controller.selectedProduct?.price.toString() ??
                    "No product selected",
                textAlign: .center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
