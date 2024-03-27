import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/service/autentication_service.dart';
import 'package:meu_jardim_app/view/details_farming.dart';

import 'package:http/http.dart' as http;

class GardenView extends StatefulWidget {
  const GardenView({super.key});

  @override
  State<GardenView> createState() => _GardenViewState();
}

class _GardenViewState extends State<GardenView> {
  CollectionReference _plants = FirebaseFirestore.instance.collection('plants');
  late String _currentUserID;
  late String name;

  late String currentMoonPhase = '';
  late String currentMoonPhaseImageURL = '';

  @override
  void initState() {
    super.initState();
    _currentUserID = AutenticationService()
        .getCurrentUserID(); // pega id do usuário logado no momento
    name = FirebaseAuth.instance.currentUser!.displayName.toString();
    fetchMoonPhase();
  }

  Future<void> fetchMoonPhase() async {
    final url = Uri.parse('https://api.hgbrasil.com/weather?woeid=456964');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final moonPhase =
          data['results']['moon_phase'] ?? ''; // pega a fase da lua
      final moonPhaseImageURL =
          getMoonPhaseImageURL(moonPhase); //pega url da imagem da fase da lua
      final nameMoon =
          translateMoonPhase(moonPhase); //traduz a fase da lua para português
      setState(() {
        currentMoonPhase = nameMoon;
        currentMoonPhaseImageURL = moonPhaseImageURL;
      });
    } else {
      throw Exception('Erro desconhecido');
    }
  }

  String translateMoonPhase(String currentMoonPhase) {
    if (currentMoonPhase == 'new') {
      return 'Lua nova';
    } else if (currentMoonPhase == 'waxing_crescent') {
      return 'Lua crescente';
    } else if (currentMoonPhase == 'first_quarter') {
      return 'Quarto crescente';
    } else if (currentMoonPhase == 'waxing_gibbous') {
      return 'Gibosa crescente';
    } else if (currentMoonPhase == 'full') {
      return 'Lua cheia';
    } else if (currentMoonPhase == 'waning_gibbous') {
      return 'Gibosa minguante';
    } else if (currentMoonPhase == 'last_quarter') {
      return 'Quarto minguante';
    } else if (currentMoonPhase == 'waning_crescent') {
      return 'Lua minguante';
    } else {
      return 'Fase da lua desconhecida';
    }
  }

  String getMoonPhaseImageURL(String moonPhase) {
    switch (moonPhase) {
      case 'new':
        return 'https://assets.hgbrasil.com/weather/icons/moon/new.png';
      case 'waxing_crescent':
        return 'https://assets.hgbrasil.com/weather/icons/moon/waxing_crescent.png';
      case 'first_quarter':
        return 'https://assets.hgbrasil.com/weather/icons/moon/first_quarter.png';
      case 'waxing_gibbous':
        return 'https://assets.hgbrasil.com/weather/icons/moon/waxing_gibbous.png';
      case 'full':
        return 'https://assets.hgbrasil.com/weather/icons/moon/full.png';
      case 'waning_gibbous':
        return 'https://assets.hgbrasil.com/weather/icons/moon/waning_gibbous.png';
      case 'last_quarter':
        return 'https://assets.hgbrasil.com/weather/icons/moon/last_quarter.png';
      case 'waning_crescent':
        return 'https://assets.hgbrasil.com/weather/icons/moon/waning_crescent.png';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.primary,
        surfaceTintColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 1,
        shadowColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        title: Text(
          'meu jardim',
          style: GoogleFonts.satisfy(
            fontSize: 27,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olá, ${name}',
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  Visibility(
                    visible: currentMoonPhase.isNotEmpty,
                    child: InkWell(
                      onTap: () => _showPhaseMoon(context),
                      child: Image.network(
                        currentMoonPhaseImageURL,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder(
                stream:
                    _plants.where('id', isEqualTo: _currentUserID).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                        child: Column(
                      children: [
                        Text('Problema ao carregar as informações!'),
                      ],
                    ));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return ListView(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset('lib/assets/no_plants.gif'),
                            Text(
                              'Vamos começar!',
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Clique no adicionar para inlcuir um novo cultivo',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var plants = snapshot.data!.docs[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsFarmingView(
                                plantData:
                                    plants.data() as Map<String, dynamic>,
                                plantDocumentId: snapshot.data!.docs[index].id,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.background,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  plants['name'],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                Visibility(
                                  visible: plants['favorite'] == true,
                                  child: Icon(
                                    PhosphorIcons.heart_fill,
                                    color: Colors.red,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Icon(
                                  PhosphorIcons.calendar_blank,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  birthdayDate(plants['date']),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  PhosphorIcons.map_pin,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(plants['location']),
                                SizedBox(
                                  width: 70,
                                ),
                                Icon(
                                  PhosphorIcons.caret_right,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _showPhaseMoon(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 320,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  PhosphorIcons.x,
                  color: Theme.of(context).colorScheme.outlineVariant,
                  size: 18,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Image.network(
                    currentMoonPhaseImageURL,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Fase atual da lua',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '${currentMoonPhase}',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 380,
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(15),
                      ),
                      child: Text(
                        textAlign: TextAlign.start,
                        'CONCLUIR',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String birthdayDate(String dataAlvoStr) {
    List<String> partes = dataAlvoStr.split('/');
    int dia = int.parse(partes[0]);
    int mes = int.parse(partes[1]);
    int ano = int.parse(partes[2]);

    DateTime dataAlvo = DateTime(ano, mes, dia);

    DateTime dataAtual = DateTime.now();
    Duration diferenca = dataAtual.difference(dataAlvo);
    int diasRestantes = diferenca.inDays;

    if (diasRestantes <= 0)
      return 'Hoje';
    else
      return diasRestantes.toString();
  }
}
