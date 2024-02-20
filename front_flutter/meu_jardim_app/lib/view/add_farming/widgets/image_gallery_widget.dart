import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showBottomImage(context);
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(PhosphorIcons.plus_bold,
                size: 35, color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }
}

Future _showBottomImage(context) {
  return showModalBottomSheet(
    context: context,
    builder: (_) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Foto do cultivo',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () => Get.back(),
                child: Icon(PhosphorIcons.trash_fill,
                    color: Theme.of(context).colorScheme.tertiary, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(PhosphorIcons.image)),
            title: Text(
              'Galeria',
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(PhosphorIcons.camera),
            ),
            title: Text(
              'Câmera',
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}
