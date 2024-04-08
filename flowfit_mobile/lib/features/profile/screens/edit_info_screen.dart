import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flowfit_mobile/features/profile/widget/icon/icon_profile_stack.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditUserInfoScreen extends StatefulWidget {
  const EditUserInfoScreen({Key? key}) : super(key: key);

  @override
  _EditUserInfoScreenState createState() => _EditUserInfoScreenState();
}

class _EditUserInfoScreenState extends State<EditUserInfoScreen> {
  String? _imageUrl;

  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  String? _profilePicturePath;
  bool _isLoading = true;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _getUserData();
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? id = prefs.getString('id');
    String url = 'https://api-zydf.onrender.com/members';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData != null && responseData is List<dynamic>) {
          for (var userData in responseData) {
            if (userData['id'].toString() == id) {
              setState(() {
                _usernameController.text = userData['username'];
                _passwordController.text = userData['password'];
                _emailController.text = userData['email'];
                _phoneController.text = userData['phone'];
                _imageUrl = userData['profile_picture'];
                _isLoading = false;
              });
              return;
            }
          }
          print('No se encontró ningún usuario con el ID proporcionado');
        } else {
          print('La respuesta del servidor no contiene datos válidos');
        }
      } else {
        print('Error al obtener los datos del usuario: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Información'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  IconProfileStack(
                    isEdit: false,
                    profile_picture: _imageUrl,
                    onImageSelected: (imagePath) {
                      setState(() {
                        _profilePicturePath =
                            imagePath; // Actualiza la ruta de la imagen en EditUserInfoScreen
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomTextField(
                          isPasswordVisible: false,
                          togglePasswordVisibility: () {},
                          controller: _usernameController,
                          label: 'Usuario',
                        ),
                        CustomTextField(
                          controller: _emailController,
                          label: 'Correo Electrónico',
                          isPasswordVisible: false,
                          togglePasswordVisibility: () {},
                        ),
                        CustomTextField(
                          isPasswordVisible: false,
                          togglePasswordVisibility: () {},
                          controller: _phoneController,
                          label: 'Número de Teléfono',
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          label: 'Contraseña',
                          isPassword: true,
                          isPasswordVisible: _isPasswordVisible,
                          togglePasswordVisibility: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _saveChanges();
                            },
                            child: const Text(
                              'Guardar Cambios',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: PrimaryTheme.secundaryColor,
                              minimumSize: const Size(double.infinity,
                                  48.0), // Adjust width and height as needed
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

 Future<void> _saveChanges() async {
  final newUsername = _usernameController.text;
  final newEmail = _emailController.text;
  final newPhone = _phoneController.text;
  final newPassword = _passwordController.text;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  String? id = prefs.getString('id');
  String url = 'https://api-zydf.onrender.com/members/$id';

  try {
    Map<String, dynamic> requestData = {
      'username': newUsername,
      'email': newEmail,
      'phone': newPhone,
      'password': newPassword,
    };

    if (_profilePicturePath != null && _profilePicturePath!.isNotEmpty) {
      // Verificar si se ha seleccionado una nueva imagen de perfil
      Uint8List imageBytes = await File(_profilePicturePath!).readAsBytes();
      requestData['profile_picture'] = base64Encode(imageBytes);
    }

    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      print('Cambios guardados exitosamente.');
      Navigator.pop(context); // Cierra la pantalla de edición después de guardar los cambios
      // Puedes agregar aquí más lógica, como navegar a otra pantalla
    } else {
      print('Error al guardar los cambios: ${response.statusCode}');
      // Manejar el error apropiadamente, como mostrar un mensaje al usuario
    }
  } catch (e) {
    print('Error de conexión: $e');
    // Manejar el error de conexión, como mostrar un mensaje al usuario
  }
}



  }
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool
      isPassword; // Nuevo parámetro para indicar si el campo es de contraseña
  final bool
      isPasswordVisible; // Nuevo parámetro para indicar si la contraseña es visible o no
  final VoidCallback
      togglePasswordVisibility; // Función para alternar la visibilidad de la contraseña

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.isPassword = false, // Por defecto el campo no es de contraseña
    required this.isPasswordVisible, // Se requiere indicar si la contraseña es visible o no
    required this.togglePasswordVisibility, // Se requiere una función para alternar la visibilidad de la contraseña
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword &&
            !isPasswordVisible, // Ocultar el texto de la contraseña si no es visible
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: PrimaryTheme.secundaryColor),
          ),
          labelText: label,
          labelStyle: const TextStyle(fontSize: 16.0, color: Colors.black54),
          border: OutlineInputBorder(),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: togglePasswordVisibility,
                )
              : null,
        ),
      ),
    );
  }
}