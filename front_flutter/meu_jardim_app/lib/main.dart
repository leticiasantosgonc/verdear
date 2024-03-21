import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:meu_jardim_app/view/home/home_view.dart';
import 'package:meu_jardim_app/utils/color_schemes.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'view/add_farming/add_farming_view.dart';
import 'view/autentication_view.dart';
import 'view/more_menu/more_view.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(colorScheme: theme),
      home: RouteView(),
      routes: {
        '/autentication': (context) => AutenticationView(),
        '/home': (context) => HomeView(),
        '/mais': (context) => MoreView(),
        '/add': (context) => AddFarmingView(),
      },
    );
  }
}

//valida se tem usuario logado
class RouteView extends StatelessWidget {
  RouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeView();
          } else {
            return AutenticationView();
          }
        });
  }
}
