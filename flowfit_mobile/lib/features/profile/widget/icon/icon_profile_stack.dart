
import 'dart:io';

import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IconProfileStack extends StatefulWidget {
  final bool isEdit;
  final Function(String?)? onImageSelected;

  const IconProfileStack({
    Key? key,
    required this.isEdit,
     this.onImageSelected,
  }) : super(key: key);

  @override
  State<IconProfileStack> createState() => _IconProfileStackState();
}

class _IconProfileStackState extends State<IconProfileStack> {
  String? _imagePath;

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
          widget.onImageSelected!(_imagePath); // Llama a la función de devolución de llamada con la ruta de la imagen seleccionada
        });
      }
    } catch (e) {
      print('Error al seleccionar la imagen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 128, 128, 128),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: PrimaryTheme.secundaryColor,
                    width: 3,
                  ),
                ),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: _imagePath != null
                    ? Image.file(
                        File(_imagePath!),
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      )
                    : Image.asset(
                        'assets/profile_example.jpg',
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
              ),
            ),
          ),
        ),
        if (widget.isEdit)
          GestureDetector(
            onTap: () {
              _pickImage();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 100),
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: PrimaryTheme.secundaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
      ],
    );
  }
}