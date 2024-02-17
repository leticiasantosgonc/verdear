import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          backgroundColor: Colors.white,
          color: Theme.of(context).colorScheme.outlineVariant,
          activeColor: Theme.of(context).colorScheme.primary,
          tabBackgroundColor: Theme.of(context).colorScheme.background,
          padding: EdgeInsets.all(8),
          gap: 8,
          onTabChange: (value) => print(value),
          tabs: [
            GButton(
              icon: PhosphorIcons.flower_thin,
              text: 'Jardim',
              onPressed: () {
                Future.delayed(Duration(milliseconds: 500), () {
                  Get.toNamed('/home');
                });
              },
            ),
            GButton(
              icon: PhosphorIcons.plus_circle,
              text: 'Adicionar',
              onPressed: () {
                Future.delayed(Duration(milliseconds: 500), () {
                  Get.toNamed('/add');
                });
              },
            ),
            GButton(
              icon: PhosphorIcons.heart,
              text: 'Favoritos',
            ),
            GButton(
              icon: PhosphorIcons.list,
              text: 'Mais',
              onPressed: () {
                Future.delayed(Duration(milliseconds: 500), () {
                  Get.toNamed('/mais');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
