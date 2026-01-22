import 'package:get/instance_manager.dart';
import 'package:viral_bites/core/bindings/sign_in_binding.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    SignInBinding().dependencies();
  }
}
