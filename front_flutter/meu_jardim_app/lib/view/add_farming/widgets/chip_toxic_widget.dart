import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/add_farming_controller.dart';

class ChipToxicWidget extends GetView<AddFarmingController> {
  const ChipToxicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tóxico',
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
              padding: const EdgeInsets.symmetric(horizontal: 30),
              avatar: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  PhosphorIcons.dog,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              elevation: 2,
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
                '',
              ),
              selected: true,
            ),
            const SizedBox(width: 10),
            ChoiceChip(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              avatar: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  PhosphorIcons.cat,
                  color: Colors.black,
                  size: 30,
                ),
              ),
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
                '',
              ),
              selected: false,
            ),
            const SizedBox(width: 10),
            ChoiceChip(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              avatar: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  PhosphorIcons.person,
                  color: Colors.black,
                  size: 30,
                ),
              ),
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
                '',
              ),
              selected: false,
            ),
          ],
        ),
      ],
    );
  }
}
