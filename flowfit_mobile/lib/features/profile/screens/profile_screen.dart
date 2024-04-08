import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flowfit_mobile/features/login/screen/login_screen.dart';
import 'package:flowfit_mobile/features/profile/screens/config_sccount_screen.dart';
import 'package:flowfit_mobile/features/profile/widget/icon/icon_profile_stack.dart';
import 'package:flowfit_mobile/features/profile/widget/textfield/custom_textfield.dart';
import 'package:flowfit_mobile/features/scanner/screen/scanner_screen.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _username;
  late String _imageUrl;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
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
              if (mounted) { // Verifica si el widget está montado antes de llamar a setState()
                setState(() {
                  _username = userData['username'];
                  _imageUrl = userData['profile_picture'];
                  _isLoading = false;
                });
              }
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
      if (mounted) { // Verifica si el widget está montado antes de llamar a setState()
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('lastLoginTime');

    // Redirigir al inicio de sesión
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MobileScannerScreen(),
              ),
            );
          },
          backgroundColor: PrimaryTheme.secundaryColor,
          child: const Icon(Icons.qr_code_scanner_outlined, color: Colors.white,),
        ),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              CustomeAppbar(
                title: 'Miembro',
                subtitle: 'Mi perfil de miembro',
              ),
              Padding(padding: EdgeInsets.all(8.0)),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   IconProfileStack(isEdit: false, profile_picture: _imageUrl,),
                  Center(
                    child: Text(
    _username.isNotEmpty ? _username : 'Loading...',
    style: FontStyle.titleTextStyle,
  ),
                  ),
                  const SizedBox(height: 20),
                  if (_username.isNotEmpty)
                    CustomFieldData(
                      title: 'Configuración de la cuenta ',
                      icon: Icons.navigate_next_outlined,
                      name: '',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfigAccountScreen(),
                          ),
                        );
                      },
                      screen: ConfigAccountScreen(),
                    ),
                  CustomFieldData(
                    title: 'Cerrar sesión',
                    icon: Icons.logout,
                    name: '',
                    screen: null,
                    onTap: () {
                      _logout();
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
