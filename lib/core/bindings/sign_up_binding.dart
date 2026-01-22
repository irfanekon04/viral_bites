import 'package:get/get.dart';
import 'package:viral_bites/feature/auth/controller/sign_up_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignUpController>(SignUpController());
  }
}
