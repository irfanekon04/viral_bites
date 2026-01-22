import 'package:get/get.dart';
import 'package:viral_bites/feature/splash/controller/splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
