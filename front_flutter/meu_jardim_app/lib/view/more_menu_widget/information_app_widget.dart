import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationAppWidget extends StatelessWidget {
  const InformationAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Theme.of(context).colorScheme.primary)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            Icon(
              PhosphorIcons.info,
            ),
            const SizedBox(width: 15),
            Text(
              'Informações do app',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 100),
            Icon(
              PhosphorIcons.caret_right,
              color: Theme.of(context).colorScheme.primary,
              size: 18,
            ),
          ]),
        ),
      ),
      onTap: () {
        _showInfoApp(context);
      },
    );
  }
}

Future _showInfoApp(context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      height: 350,
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
                  PhosphorIcons.flower_fill,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 15),
                Text(
                  'Informações do app',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'O meu jardim é um aplicativo para auxiliar na rotina das suas plantinhas. Aqui você consegue armazenar informações necessárias sobre cada cultivo.',
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
