import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:simple_logic/ui/login_screen.dart';
import 'package:simple_logic/utils/constants/strings.dart';
import 'package:simple_logic/utils/router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Simple Logic',
      debugShowCheckedModeBanner: false,
        initialRoute: StringConstant.loginScreen,
        getPages: RouterForScreen.routes
    );
  }
}