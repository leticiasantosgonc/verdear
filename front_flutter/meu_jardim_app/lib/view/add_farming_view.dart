import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFarmingView extends StatelessWidget {
  AddFarmingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.primary,
        title: Text(
          'Cadastrar',
          style: GoogleFonts.montserrat(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Form(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/no_plant.png'),
            ),
          ],
        ),
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
      duration: const Duration(seconds: 3),
    );
  }

// Future _showBottomImage(context) {
//   return showModalBottomSheet(
//     context: context,
//     builder: (_) => Padding(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Foto do cultivo',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               InkWell(
//                 onTap: () => Get.back(),
//                 child: Icon(PhosphorIcons.trash_fill,
//                     color: Theme.of(context).colorScheme.tertiary, size: 24),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           ListTile(
//             leading: CircleAvatar(
//                 backgroundColor: Theme.of(context).colorScheme.primary,
//                 child: Icon(PhosphorIcons.image)),
//             title: Text(
//               'Galeria',
//               style: GoogleFonts.montserrat(
//                   fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Theme.of(context).colorScheme.primary,
//               child: Icon(PhosphorIcons.camera),
//             ),
//             title: Text(
//               'Câmera',
//               style: GoogleFonts.montserrat(
//                   fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     ),
//   );
}
