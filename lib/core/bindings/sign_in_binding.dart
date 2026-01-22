import 'package:get/get.dart';
import 'package:viral_bites/feature/auth/controller/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignInController>(SignInController(), permanent: true);
  }
}
