import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meu_jardim_app/view/navigation_view.dart';

class EditFarmingView extends StatefulWidget {
  final String plantId;

  const EditFarmingView({Key? key, required this.plantId}) : super(key: key);

  @override
  _EditFarmingViewState createState() => _EditFarmingViewState();
}

class _EditFarmingViewState extends State<EditFarmingView> {
  final CollectionReference _plants =
      FirebaseFirestore.instance.collection('plants');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final formEditKey = GlobalKey<FormState>();

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

  @override
  void initState() {
    super.initState();
    loadPlantData();
  }

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  void _loadSelectedImage() {
    if (_selectedImage != null) {
      setState(() {
        Uri uri = Uri.file(_selectedImage!.path);
        _imageUrl = uri.toString();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    }
  }

  void loadPlantData() async {
    try {
      DocumentSnapshot snapshot = await _plants.doc(widget.plantId).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          _nameController.text = data['name'] ?? '';
          _botanicalNameController.text = data['name_botanical'] ?? '';
          _descriptionController.text = data['description'] ?? '';
          _speciesController.text = data['species'] ?? '';
          _locationController.text = data['location'] ?? '';
          _dateController.text = data['date'] ?? '';
          _isCatToxicSelected = data['cat_toxic'] ?? false;
          _isDogToxicSelected = data['dog_toxic'] ?? false;
          _isHumanToxicSelected = data['human_toxic'] ?? false;
          _imageUrl = data['image'];
        });
      } else {
        _showToast('Planta não encontrada.');
      }
    } catch (error) {
      print('Erro ao carregar dados da planta: $error');
      _showToast('Erro ao carregar dados da planta.');
    }
  }

  void updatePlant() async {
    if (formEditKey.currentState!.validate()) {
      try {
        _isLoading = true;
        String downloadUrl = _imageUrl ?? '';
        if (_selectedImage != null) {
          File file = File(_selectedImage!.path);
          String ref = 'images/${widget.plantId}.jpg';

          TaskSnapshot snapshot = await _storage.ref(ref).putFile(file);
          downloadUrl = await snapshot.ref.getDownloadURL();
        }

        await _plants.doc(widget.plantId).update({
          'name': _nameController.text,
          'name_botanical': _botanicalNameController.text,
          'description': _descriptionController.text,
          'species': _speciesController.text,
          'location': _locationController.text,
          'date': _dateController.text,
          'cat_toxic': _isCatToxicSelected,
          'dog_toxic': _isDogToxicSelected,
          'human_toxic': _isHumanToxicSelected,
          'image': downloadUrl,
        });

        _showToast('Cultivo atualizado com sucesso!');
        Get.offAll(() => NavegationView(), predicate: (route) => route.isFirst);
        _isLoading = false;
      } catch (error) {
        _showToast('Erro ao atualizar cultivo: $error');
      }
    }
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
          'Editar',
          style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Form(
                    key: formEditKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _selectedImage != null
                              ? FileImage(File(_selectedImage!.path))
                              : (_imageUrl != null
                                  ? NetworkImage(_imageUrl!)
                                  : null) as ImageProvider<Object>?,
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            _showImageOptions();
                          },
                          child: Text(
                            'Alterar foto',
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira o nome da planta';
                              }
                              return null;
                            },
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
                          child: TextFormField(
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
                          child: TextFormField(
                            controller: _descriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira a descrição da planta';
                              }
                              return null;
                            },
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
                                      color:
                                          Theme.of(context).colorScheme.outline,
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
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      backgroundColor: _isCatToxicSelected
                                          ? Colors.green
                                          : Theme.of(context)
                                              .colorScheme
                                              .surface,
                                      avatar: Icon(
                                        PhosphorIcons.cat,
                                        color: _isCatToxicSelected
                                            ? Colors.white
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
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
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      backgroundColor: _isDogToxicSelected
                                          ? Colors.green
                                          : Theme.of(context)
                                              .colorScheme
                                              .surface,
                                      avatar: Icon(
                                        PhosphorIcons.dog,
                                        color: _isDogToxicSelected
                                            ? Colors.white
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
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
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      backgroundColor: _isHumanToxicSelected
                                          ? Colors.green
                                          : Theme.of(context)
                                              .colorScheme
                                              .surface,
                                      avatar: Icon(
                                        PhosphorIcons.user,
                                        color: _isHumanToxicSelected
                                            ? Colors.white
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
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
                              _selectedDate();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: updatePlant,
        child: Icon(Icons.save),
      ),
    );
  }

  void _showToast(String message) {
    Get.snackbar(
      'Aviso',
      message,
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
      });
      _loadSelectedImage();
    }
  }
}
