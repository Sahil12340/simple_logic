import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:simple_logic/ui/chat_detail_screen.dart';
import 'package:simple_logic/ui/chat_screen.dart';
import 'package:simple_logic/ui/login_screen.dart';
import 'package:simple_logic/ui/sign_up_screen.dart';

import 'constants/strings.dart';

class RouterForScreen {
  static final routes = [
    GetPage(name: StringConstant.loginScreen, page: () => const LoginScreen()),
    GetPage(
        name: StringConstant.signUpScreen, page: () => const SignUpScreen()),
    GetPage(name: StringConstant.chatScreen, page: () => const ChatScreen()),
    GetPage(
        name: StringConstant.chatDetailScreen,
        page: () => ChatDetailScreen(Get.arguments))
  ];
}
