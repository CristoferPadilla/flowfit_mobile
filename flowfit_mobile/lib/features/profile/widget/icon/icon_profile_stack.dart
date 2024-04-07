import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';

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
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final imageUrl = prefs.getString('profile_picture'); // Utiliza la misma clave utilizada en _getUserData()
    if (imageUrl != null && imageUrl.isNotEmpty) {
      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        final String imageUrl = pickedFile.path;
        setState(() {
          _imageUrl = imageUrl;
        });
        // No es necesario guardar la imagen local en SharedPreferences aquí
        // ya que solo la usamos para mostrarla temporalmente.
        // Guardar la imagen en el servidor se manejará en EditUserInfoScreen.
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
              decoration: BoxDecoration(
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
                child: _imageUrl != null
                    ? Image.file(
                        File(_imageUrl!), // Carga la imagen local desde la ruta
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      )
                    : Container(
                        color: Colors.red,
                      ),
              ),
            ),
          ),
        ),
        if (widget.isEdit)
          GestureDetector(
            onTap: _pickImage,
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 100),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: PrimaryTheme.secundaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
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
