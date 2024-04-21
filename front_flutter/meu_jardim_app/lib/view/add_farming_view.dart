import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meu_jardim_app/view/navigation_view.dart';
import 'package:uuid/uuid.dart';

class AddFarmingView extends StatefulWidget {
  AddFarmingView({super.key});

  @override
  State<AddFarmingView> createState() => _AddFarmingViewState();
}

class _AddFarmingViewState extends State<AddFarmingView> {
  CollectionReference _plants = FirebaseFirestore.instance.collection('plants');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final formAddKey = GlobalKey<FormState>();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _botanicalNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _speciesController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  bool _isCatToxicSelected = false;
  bool _isDogToxicSelected = false;
  bool _isHumanToxicSelected = false;

  String? _imageUrl;
  XFile? _selectedImage;
  bool _isLoading = false;

  void _toggleCatToxic() {
    setState(() {
      _isCatToxicSelected = !_isCatToxicSelected;
    });
  }

  void _toggleDogToxic() {
    setState(() {
      _isDogToxicSelected = !_isDogToxicSelected;
    });
  }

  void _toggleHumanToxic() {
    setState(() {
      _isHumanToxicSelected = !_isHumanToxicSelected;
    });
  }

  void addPlant() async {
    String downloadUrl = '';
    String plantId = Uuid().v4();

    if (formAddKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      if (_selectedImage == null ||
          _nameController.text.isEmpty ||
          _locationController.text.isEmpty ||
          _dateController.text.isEmpty) {
        Get.snackbar(
          'Erro ao cadastrar cultivo',
          'Por favor, preencha os dados obrigatórios. Foto, nome, local e data de plantio.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      if (_selectedImage != null) {
        File file = File(_selectedImage!.path);
        String ref = 'images/$plantId.jpg';
        TaskSnapshot snapshot = await _storage.ref(ref).putFile(file);
        downloadUrl = await snapshot.ref.getDownloadURL();
      }

      DocumentReference ref = await _plants.add({
        'id_doc': '',
        'id': FirebaseAuth.instance.currentUser!.uid,
        'id_plant': plantId,
        'name': _nameController.text,
        'name_botanical': _botanicalNameController.text,
        'description': _descriptionController.text,
        'species': _speciesController.text,
        'location': _locationController.text,
        'date': _dateController.text,
        'favorite': false,
        'dog_toxic': _isDogToxicSelected,
        'cat_toxic': _isCatToxicSelected,
        'human_toxic': _isHumanToxicSelected,
        'image': downloadUrl,
      });
      String docId = ref.id;
      await _plants.doc(docId).update({'id_doc': docId});
      _nameController.clear();
      _botanicalNameController.clear();
      _descriptionController.clear();
      _speciesController.clear();
      _locationController.clear();
      _dateController.clear();

      _showToast();
      Get.offAll(() => NavegationView(), predicate: (route) => route.isFirst);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  void _loadSelectedImage() {
    if (_selectedImage != null) {
      setState(() {
        _imageUrl = _selectedImage!.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              key: formAddKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        _imageUrl != null ? FileImage(File(_imageUrl!)) : null,
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      _showImageOptions();
                    },
                    child: Text(
                      'Adicionar foto',
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 60,
                    child: TextFormField(
                      controller: _nameController,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
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
                      textCapitalization: TextCapitalization.sentences,
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      textCapitalization: TextCapitalization.sentences,
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
                        hintText: 'Ex: Adubação, rega diária...',
                        labelText: 'Descrição',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 60,
                    child: DropdownButtonFormField<String>(
                      value: _speciesController.text.isNotEmpty
                          ? _speciesController.text
                          : null,
                      onChanged: (newValue) {
                        setState(() {
                          _speciesController.text = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'Planta',
                          child: Text('Planta'),
                        ),
                        DropdownMenuItem(
                          value: 'Flores',
                          child: Text('Flores'),
                        ),
                        DropdownMenuItem(
                          value: 'Hortaliças',
                          child: Text('Hortaliças'),
                        ),
                        DropdownMenuItem(
                          value: 'Temperos',
                          child: Text('Temperos'),
                        ),
                        DropdownMenuItem(
                          value: 'Chás',
                          child: Text('Chás'),
                        ),
                        DropdownMenuItem(
                          value: 'outro',
                          child: Text('Outro'),
                        ),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Espécie',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Tóxico: ',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.outline,
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _toggleCatToxic,
                              child: Chip(
                                label: Text(
                                  'Gato',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _isCatToxicSelected
                                        ? Colors.white
                                        : Theme.of(context).colorScheme.outline,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                backgroundColor: _isCatToxicSelected
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.surface,
                                avatar: Icon(
                                  PhosphorIcons.cat,
                                  color: _isCatToxicSelected
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.primary,
                                  size: 18,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: _toggleDogToxic,
                              child: Chip(
                                label: Text(
                                  'Cachorro',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _isDogToxicSelected
                                        ? Colors.white
                                        : Theme.of(context).colorScheme.outline,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                backgroundColor: _isDogToxicSelected
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.surface,
                                avatar: Icon(
                                  PhosphorIcons.dog,
                                  color: _isDogToxicSelected
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.primary,
                                  size: 18,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: _toggleHumanToxic,
                              child: Chip(
                                label: Text(
                                  'Humano',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _isHumanToxicSelected
                                        ? Colors.white
                                        : Theme.of(context).colorScheme.outline,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                backgroundColor: _isHumanToxicSelected
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.surface,
                                avatar: Icon(
                                  PhosphorIcons.user,
                                  color: _isHumanToxicSelected
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.primary,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 60,
                    child: DropdownButtonFormField<String>(
                      value: _locationController.text.isNotEmpty
                          ? _locationController.text
                          : null,
                      onChanged: (newValue) {
                        setState(() {
                          _locationController.text = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'Horta',
                          child: Text('Horta'),
                        ),
                        DropdownMenuItem(
                          value: 'Jardim',
                          child: Text('Jardim'),
                        ),
                        DropdownMenuItem(
                          value: 'Sala',
                          child: Text('Sala'),
                        ),
                        DropdownMenuItem(
                          value: 'Quarto',
                          child: Text('Quarto'),
                        ),
                        DropdownMenuItem(
                          value: 'Varanda',
                          child: Text('Varanda'),
                        ),
                        DropdownMenuItem(
                          value: 'Outro',
                          child: Text('Outro'),
                        ),
                      ],
                      decoration: InputDecoration(
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
                  Container(
                    height: 60,
                    child: TextFormField(
                      controller: _dateController,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Data do plantio',
                        suffixIcon: Icon(PhosphorIcons.calendar),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        if (!_isLoading) _selectedDate();
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 380,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : () => addPlant(),
                      style: TextButton.styleFrom(
                        backgroundColor: _isLoading
                            ? Colors.grey
                            : Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(15),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
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
      'Cultivo cadastrado',
      'Seu cultivo foi cadastrado com sucesso! 😃',
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
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickDate != null)
      _dateController.text = DateFormat('dd/MM/yyyy')
          .format(DateTime.parse(pickDate.toString().split(" ")[0]));
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(25),
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              PhosphorIcons.camera,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                          Text(
                            'Câmera',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              pickAndUploadImage();
                              Get.close(1);
                            },
                            icon: Icon(
                              PhosphorIcons.image,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                          Text(
                            'Galeria',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void pickAndUploadImage() async {
    XFile? image = await getImage();
    if (image != null) {
      setState(() {
        _selectedImage = image;
        _loadSelectedImage();
      });
    }
  }
}
