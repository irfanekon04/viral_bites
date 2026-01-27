import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viral_bites/core/utils/constants/app_colors.dart';
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
            Obx(
              ()=> TextButton(
                onPressed: controller.fetchProducts,
                child: Text('Products: ${controller.products.length}'),
              ),
            ),
            Obx(
              () => Expanded(
                child: controller.isLoading.value
                    ? SpinKitCircle(color: AppColors.primary)
                    : ListView.builder(
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
              ),
            ),
            Obx(()=> Text('${controller.counterVar.value}',style: GoogleFonts.poppins(color: AppColors.textPrimary, fontSize: 48,fontWeight: .bold))),
            Row(mainAxisAlignment: .center,
              children: [
                FloatingActionButton(heroTag: 'decrement', onPressed: (){controller.counterDecrement();}, child: Icon(Icons.remove),),Gap(10),
                FloatingActionButton(heroTag: 'increment', onPressed: (){controller.counterIncrement();}, child: Icon(Icons.add),),
              ],
            )
          ],
        ),
        
      ),
    );
  }
}
