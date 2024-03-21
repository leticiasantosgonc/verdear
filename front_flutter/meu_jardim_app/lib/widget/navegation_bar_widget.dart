import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:meu_jardim_app/view/add_farming/add_farming_view.dart';
import 'package:meu_jardim_app/view/home/home_view.dart';
import 'package:meu_jardim_app/view/more_menu/more_view.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.onTertiary,
        indicatorColor: Theme.of(context).colorScheme.onTertiary,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(PhosphorIcons.flower_fill),
            icon: Icon(PhosphorIcons.flower_thin),
            label: 'Jardim',
          ),
          NavigationDestination(
            selectedIcon: Icon(PhosphorIcons.plus_circle_fill),
            icon: Icon(PhosphorIcons.plus_circle),
            label: 'Adicionar',
          ),
          NavigationDestination(
            selectedIcon: Icon(PhosphorIcons.heart_fill),
            icon: Icon(PhosphorIcons.heart),
            label: 'Favoritos',
          ),
          NavigationDestination(
            selectedIcon: Icon(PhosphorIcons.list_fill),
            icon: Icon(PhosphorIcons.list),
            label: 'Mais',
          ),
        ],
      ),
      // body: <Widget>[][currentPageIndex],
    );
  }
}
