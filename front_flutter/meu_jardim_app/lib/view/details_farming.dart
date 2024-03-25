import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
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
              child: Padding(
                padding: const EdgeInsets.all(16),
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
                        InkWell(
                          onTap: () {
                            _showDialogDelete(context);
                          },
                          child: Icon(
                            PhosphorIcons.trash_fill,
                            size: 20,
                          ),
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
                        Icon(PhosphorIcons.planet),
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

  void _deletePlant() {
    FirebaseFirestore.instance
        .collection('plants')
        .doc(widget.plantDocumentId)
        .delete()
        .then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      print('Erro ao deletar planta: $error');
    });
  }

  Future _showDialogDelete(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
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
                  Icon(
                    PhosphorIcons.trash,
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Excluir plantio?',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Deseja prosseguir com a exclusão do plantio? 😢',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        child: TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(15),
                          ),
                          child: Text(
                            textAlign: TextAlign.start,
                            'CANCELAR',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 120,
                        child: TextButton(
                          onPressed: () {
                            _deletePlant();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(15),
                          ),
                          child: Text(
                            textAlign: TextAlign.start,
                            'SAIR',
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
            ],
          ),
        ),
      ),
    );
  }
}
