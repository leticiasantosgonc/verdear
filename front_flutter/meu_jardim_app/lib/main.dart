import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_jardim_app/screen/home/home_screen.dart';
import 'package:meu_jardim_app/utils/color_schemes.g.dart';

import 'screen/add_cultivo/add_cultivo_screen.dart';
import 'screen/login/login_bindings.dart';
import 'screen/mais_menu/mais_screen.dart';
import 'screen/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: LoginBindings(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(colorScheme: theme),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/mais': (context) => MaisScreen(),
        '/add': (context) => AddPlantaScreen(),
      },
    );
  }
}
