import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/view/add_farming_view.dart';
import 'package:meu_jardim_app/view/garden_view.dart';
import 'package:meu_jardim_app/view/more_menu/more_view.dart';

class HouseView extends StatefulWidget {
  const HouseView({super.key});

  @override
  State<HouseView> createState() => _HouseViewState();
}

class _HouseViewState extends State<HouseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: Text(
          'Inicio',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(GardenView());
                },
                child: Card(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          PhosphorIcons.house_line,
                          color: Colors.white,
                        ),
                      ),
                      _SampleCard(cardName: 'Elevated Card'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(AddFarmingView());
                },
                child: Card(
                    child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        PhosphorIcons.house_line,
                        color: Colors.white,
                      ),
                    ),
                    _SampleCard(cardName: 'Elevated Card'),
                  ],
                )),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(GardenView());
                },
                child: Card(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          PhosphorIcons.house_line,
                          color: Colors.white,
                        ),
                      ),
                      _SampleCard(cardName: 'Elevated Card'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(MoreView());
                },
                child: Card(
                    child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        PhosphorIcons.house_line,
                        color: Colors.white,
                      ),
                    ),
                    _SampleCard(cardName: 'Elevated Card'),
                  ],
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Center(child: Text(cardName)),
    );
  }
}
