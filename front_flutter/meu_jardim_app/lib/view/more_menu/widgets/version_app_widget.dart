import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class VersionAppWidget extends StatelessWidget {
  const VersionAppWidget({super.key});

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
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(PhosphorIcons.arrows_clockwise),
                ],
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Versão do app',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('1.0.0'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
