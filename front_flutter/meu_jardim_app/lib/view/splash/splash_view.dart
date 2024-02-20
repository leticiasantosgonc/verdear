import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:meu_jardim_app/view/login/login_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Transform.scale(
        scale: 3,
        child: Image.asset('lib/assets/splash.gif'),
      ),
      nextScreen: LoginView(),
    );
  }
}
