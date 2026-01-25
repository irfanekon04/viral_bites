import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:viral_bites/feature/home/controller/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: .end,
              children: [
                IconButton(
                  onPressed: () {
                    controller.getUserProfile();
                  },
                  icon: Icon(Icons.person),
                ),
              ],
            ),
            Gap(10),
            TextButton(
              onPressed: controller.fetchProducts,
              child: Text('Products'),
            ),
            Obx(() {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return ListTile(
                      onTap: () => controller.getSingleProduct(product),
                      title: Text(product.name),
                      subtitle: Text('\$${product.price}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          controller.deleteProduct(product.id);
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
