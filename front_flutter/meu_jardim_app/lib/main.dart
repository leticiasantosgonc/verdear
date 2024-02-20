import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_jardim_app/view/home/home_view.dart';
import 'package:meu_jardim_app/utils/color_schemes.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'view/add_farming/add_farming_view.dart';
import 'view/login/login_view.dart';
import 'view/more_menu/more_view.dart';
import 'view/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const SplashView(),
      routes: {
        '/home': (context) => HomeView(),
        '/mais': (context) => MoreView(),
        '/add': (context) => AddFarmingView(),
      },
    );
  }
}
