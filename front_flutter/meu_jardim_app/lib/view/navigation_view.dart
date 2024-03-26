import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:meu_jardim_app/view/add_farming_view.dart';
import 'package:meu_jardim_app/view/favorite_view.dart';
import 'package:meu_jardim_app/view/garden_view.dart';
import 'package:meu_jardim_app/view/more_menu/more_view.dart';

class NavegationView extends StatefulWidget {
  NavegationView({super.key});

  @override
  State<NavegationView> createState() => _NavegationViewState();
}

class _NavegationViewState extends State<NavegationView> {
  int pageIndex = 0;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          GardenView(),
          AddFarmingView(),
          FavoriteView(),
          MoreView(),
        ],
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.primary,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          selectedFontSize: 8,
          unselectedFontSize: 8,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          currentIndex: pageIndex,
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(PhosphorIcons.flower_fill),
              icon: Icon(PhosphorIcons.flower_thin),
              label: 'Jardim',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(PhosphorIcons.plus_circle_fill),
              icon: Icon(PhosphorIcons.plus_circle),
              label: 'Adicionar',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(PhosphorIcons.heart_fill),
              icon: Icon(PhosphorIcons.heart),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(PhosphorIcons.list_fill),
              icon: Icon(PhosphorIcons.list),
              label: 'Mais',
            ),
          ],
          onTap: (index) {
            setState(() {
              controller.animateToPage(
                index,
                duration: Duration(milliseconds: 1),
                curve: Curves.linear,
              );
            });
          },
        ),
      ),
    );
  }
}
