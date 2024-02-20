import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/add_farming_controller.dart';

class ChipLightWidget extends GetView<AddFarmingController> {
  const ChipLightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Luminosidade',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ChoiceChip(
              padding: EdgeInsets.symmetric(horizontal: 8),
              disabledColor: Colors.white,
              selectedColor: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1,
              ),
              label: Text(
                'Sol pleno',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              selected: true,
            ),
            const SizedBox(width: 10),
            ChoiceChip(
              padding: EdgeInsets.symmetric(horizontal: 8),
              disabledColor: Colors.white,
              selectedColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1,
              ),
              label: Text(
                'Claridade',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              selected: false,
            ),
            const SizedBox(width: 10),
            ChoiceChip(
              padding: EdgeInsets.symmetric(horizontal: 15),
              disabledColor: Colors.white,
              selectedColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1,
              ),
              label: Text(
                'Sombra',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              selected: false,
            ),
          ],
        ),
      ],
    );
  }
}
