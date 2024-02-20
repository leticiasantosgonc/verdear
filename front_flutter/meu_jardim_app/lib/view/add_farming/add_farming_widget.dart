import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/add_farming_controller.dart';

class AddFarmingWidget extends GetView<AddFarmingController> {
  const AddFarmingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                    height: 125,
                    child: InkWell(
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
                                size: 35,
                                color: Theme.of(context).colorScheme.primary),
                          ],
                        ),
                      ),
                    )),
              ),
              SizedBox(width: 10),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Nome Botânico',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Ex: Planta de sol, rega diária...',
                labelText: 'Descrição',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              decoration: const InputDecoration(
                hintText: 'Ex: Raiz, orquídea, suculenta...',
                labelText: 'Espécie',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              decoration: const InputDecoration(
                hintText: 'Ex: Jardim, horta, varanda...',
                labelText: 'Local',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
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
          ),
          const SizedBox(height: 10),
          Column(
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
          ),
          const SizedBox(height: 15),
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
                  onPressed: () {
                    Get.back();
                    _showToast();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Text(
                    textAlign: TextAlign.start,
                    'CADASTRAR',
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
    );
  }
}

void _showToast() {
  Get.snackbar(
    'Cultivo cadastrado',
    'Seu cultivo foi cadastrado com sucesso! 😃',
    backgroundColor: Colors.green,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    duration: const Duration(seconds: 3),
  );
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
