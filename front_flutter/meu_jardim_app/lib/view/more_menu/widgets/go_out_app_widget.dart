import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GoOutAppWidget extends StatelessWidget {
  const GoOutAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            )),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            Icon(PhosphorIcons.power),
            const SizedBox(width: 15),
            Text(
              'Sair',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 220),
            Icon(
              PhosphorIcons.caret_right,
              color: Theme.of(context).colorScheme.outlineVariant,
              size: 18,
            ),
          ]),
        ),
      ),
      onTap: () {
        _showBottomSair(context);
      },
    );
  }
}

Future _showBottomSair(context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
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
                  PhosphorIcons.sign_out,
                  size: 70,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 15),
                Text(
                  'Sair do app?',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Deseja realmente sair da sua conta? Seus cultivos sentirão sua falta! 😢',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
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
                      width: 150,
                      child: TextButton(
                        onPressed: () => Get.back(),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
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
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 150,
                      child: TextButton(
                        onPressed: () => Get.back(),
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
                            fontSize: 18,
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
