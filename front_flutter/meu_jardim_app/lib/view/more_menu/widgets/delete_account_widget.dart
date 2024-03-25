import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/service/autentication_service.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            )),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            Icon(PhosphorIcons.trash),
            const SizedBox(width: 15),
            Text(
              'Excluir conta',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 152),
            Icon(
              PhosphorIcons.caret_right,
              color: Theme.of(context).colorScheme.outlineVariant,
              size: 18,
            ),
          ]),
        ),
      ),
      onTap: () {
        _showBottomExcluir(context);
      },
    );
  }
}

Future _showBottomExcluir(context) {
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
                  PhosphorIcons.trash_fill,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 15),
                Text(
                  'Excluir conta',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Deseja realmente excluir sua conta?',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Seus plantios merecem cuidados. 🥀',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                  ),
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
                          AutenticationService().deleteAccount();
                          Get.close(0);
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
                          'EXCLUIR',
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
