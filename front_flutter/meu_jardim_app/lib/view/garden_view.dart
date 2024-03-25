import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/service/autentication_service.dart';
import 'package:meu_jardim_app/view/details_farming.dart';

class GardenView extends StatefulWidget {
  const GardenView({super.key});

  @override
  State<GardenView> createState() => _GardenViewState();
}

class _GardenViewState extends State<GardenView> {
  CollectionReference _plants = FirebaseFirestore.instance.collection('plants');
  TextEditingController _gardenController = TextEditingController();
  late String _currentUserID;

  @override
  void initState() {
    super.initState();
    _currentUserID = AutenticationService()
        .getCurrentUserID(); // Obtendo o ID do usuário atual
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).colorScheme.background,
        surfaceTintColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 1,
        shadowColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : const Color.fromRGBO(238, 238, 238, 1),
        title: Text(
          'meu jardim',
          style: GoogleFonts.satisfy(
              fontSize: 27,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _gardenController,
              decoration: InputDecoration(
                suffixIcon: Icon(PhosphorIcons.pencil),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: _plants
                    .where('id', isEqualTo: _currentUserID)
                    .snapshots() // Adicionando o filtro por ID do usuário
                ,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Você ainda não tem plantios. Adicione para começar!',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              PhosphorIcons.caret_down,
                              size: 20,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              child: Image.asset('lib/assets/plus_garden.gif'),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var plants = snapshot.data!.docs[index];
                      return Dismissible(
                        key: Key(plants.id),
                        onDismissed: (direction) {
                          _plants.doc(plants.id).delete();
                        },
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsFarmingView(
                                  plantData:
                                      plants.data() as Map<String, dynamic>,
                                  plantDocumentId:
                                      snapshot.data!.docs[index].id,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Theme.of(context).colorScheme.surface
                                    : Theme.of(context).colorScheme.background,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  )
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Icon(PhosphorIcons.cake),
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
                                  Icon(PhosphorIcons.map_pin),
                                  Text(plants['location']),
                                  SizedBox(
                                    width: 70,
                                  ),
                                  Icon(
                                    PhosphorIcons.caret_right,
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
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
