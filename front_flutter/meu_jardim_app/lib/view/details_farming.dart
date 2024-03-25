import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsFarmingView extends StatefulWidget {
  final Map<String, dynamic> plantData;
  final String plantDocumentId;

  const DetailsFarmingView(
      {Key? key, required this.plantData, required this.plantDocumentId})
      : super(key: key);

  @override
  State<DetailsFarmingView> createState() => _DetailsFarmingViewState();
}

class _DetailsFarmingViewState extends State<DetailsFarmingView> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.plantData['favorite'] ?? false;
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
            : Colors.grey[200],
        title: Text(
          'Detalhes',
          style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: ListView(
          children: [
            Card(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.background,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                            _updateFavoriteStatus(isFavorite);
                          });
                        },
                        child: Icon(
                          isFavorite
                              ? PhosphorIcons.heart_fill
                              : PhosphorIcons.heart,
                          size: 20,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(PhosphorIcons.pencil_fill, size: 20),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        PhosphorIcons.trash_fill,
                        size: 20,
                      )
                    ],
                  ),
                  Text(
                    widget.plantData['name'],
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                    ),
                  ),
                  Text(widget.plantData['name_botanical'],
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.plantData['description'],
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Icon(PhosphorIcons.cake),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        birthdayDate(widget.plantData['date']),
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(PhosphorIcons.map_pin),
                      Text(widget.plantData['location']),
                      SizedBox(
                        width: 70,
                      ),
                    ],
                  )
                ],
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

  void _updateFavoriteStatus(bool isFavorite) {
    FirebaseFirestore.instance
        .collection('plants')
        .doc(widget.plantDocumentId)
        .update({'favorite': isFavorite}).then((_) {
      setState(() {
        this.isFavorite = isFavorite;
      });
      print('Status de favorito atualizado no Firestore');
    }).catchError((error) {
      print('Erro ao atualizar status de favorito: $error');
    });
  }
}
