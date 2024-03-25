import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:meu_jardim_app/view/garden_view.dart';
import 'package:uuid/uuid.dart';

class AddFarmingView extends StatefulWidget {
  AddFarmingView({super.key});

  @override
  State<AddFarmingView> createState() => _AddFarmingViewState();
}

class _AddFarmingViewState extends State<AddFarmingView> {
  CollectionReference _plants = FirebaseFirestore.instance.collection('plants');

  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _botanicalNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _speciesController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  void addPlant() {
    _plants.add({
      'id': FirebaseAuth.instance.currentUser!.uid,
      'id_plant': Uuid().v4(),
      'name': _nameController.text,
      'name_botanical': _botanicalNameController.text,
      'description': _descriptionController.text,
      'species': _speciesController.text,
      'location': _locationController.text,
      'date': _dateController.text,
      'favorite': false,
    });
    _nameController.clear();
    _botanicalNameController.clear();
    _descriptionController.clear();
    _speciesController.clear();
    _locationController.clear();
    _dateController.clear();
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
          'Cadastrar',
          style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(''),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Adicionar foto',
                    style: GoogleFonts.montserrat(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 60,
                    child: TextField(
                      controller: _nameController,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 60,
                    child: TextField(
                      controller: _botanicalNameController,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Nome botânico',
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 100,
                    child: TextField(
                      controller: _descriptionController,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Ex: Tóxica para gatos, rega diária...',
                        labelText: 'Descrição',
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 60,
                    child: TextField(
                      controller: _speciesController,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Ex: Raiz, orquídea, suculenta...',
                        labelText: 'Espécie',
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 60,
                    child: TextField(
                      controller: _locationController,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Ex: Jardim, horta, varanda...',
                        labelText: 'Local',
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 60,
                    child: TextField(
                      controller: _dateController,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Data de plantio',
                        suffixIcon: Icon(PhosphorIcons.calendar),
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        _selectedDate();
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 120,
                    child: TextButton(
                      onPressed: () {
                        addPlant();
                        Get.to(GardenView());
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
                        'SALVAR',
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
            ),
          ),
        ],
      ),
    );
  }

  void _showToast() {
    Get.snackbar(
      'Plantio cadastrado',
      'Seu plantio foi cadastrado com sucesso! 😃',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> _selectedDate() async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickDate != null)
      _dateController.text = DateFormat('dd/MM/yyyy')
          .format(DateTime.parse(pickDate.toString().split(" ")[0]));
  }
}
