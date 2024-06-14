import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AssessAppWidget extends StatefulWidget {
  const AssessAppWidget({super.key});

  @override
  State<AssessAppWidget> createState() => _AssessAppWidgetState();
}

class _AssessAppWidgetState extends State<AssessAppWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            )),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            Icon(
              PhosphorIcons.smiley,
            ),
            const SizedBox(width: 15),
            Text(
              'Avalie o app',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 156),
            Icon(
              PhosphorIcons.caret_right,
              color: Theme.of(context).colorScheme.primary,
              size: 18,
            ),
          ]),
        ),
      ),
      onTap: () {
        _showBottomAvalie(context);
      },
    );
  }
}

Future<void> sendNote(int note) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: '08220188@aluno.osorio.ifrs.edu.br',
    query: 'subject=Avaliação do App&body=Nota: $note estrelas',
  );

  try {
    await launchUrl(emailUri);
  } catch (e) {
    Get.snackbar(
      'Erro',
      'Não foi possível enviar a avaliação.',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

Future _showBottomAvalie(context) {
  int _note = 0;
  return showModalBottomSheet(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 380,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Icon(
                      PhosphorIcons.thumbs_up_fill,
                      size: 50,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Gostou do app?',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Sua avaliação é muito importante para que o app continue melhorando. 😃',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              _note = index + 1;
                            });
                          },
                          icon: Icon(
                            _note > index
                                ? PhosphorIcons.star_fill
                                : PhosphorIcons.star,
                            color: _note > index
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                            size: 20,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 160,
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
                          width: 160,
                          child: TextButton(
                            onPressed: () async {
                              Get.back();
                              await sendNote(_note);
                              Get.snackbar(
                                'Avaliação enviada',
                                'Obrigado por avaliar o app!',
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
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
                              'ENVIAR',
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
        );
      },
    ),
  );
}
