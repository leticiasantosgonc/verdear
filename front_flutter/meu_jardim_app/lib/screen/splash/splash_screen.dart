import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:meu_jardim_app/screen/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Transform.scale(
        scale: 3,
        child: Image.asset('lib/assets/splash.gif'),
      ),
      nextScreen: LoginScreen(),
    );
  }
}
