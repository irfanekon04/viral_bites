import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viral_bites/feature/home/controller/home_screen_controller.dart';
import 'package:viral_bites/feature/home/screen/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home Screen',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: .bold),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => NotificationsScreen()),

            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              controller.getUserProfile();
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
