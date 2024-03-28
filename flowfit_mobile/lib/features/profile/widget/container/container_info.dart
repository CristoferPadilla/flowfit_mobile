// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';

class ContainerInfo extends StatefulWidget {
   ContainerInfo({Key? key}) : super(key: key);

  @override
  _ContainerInfoState createState() => _ContainerInfoState();
}

class _ContainerInfoState extends State<ContainerInfo> {
  late String _username = '';
  late String _email = '';
  // late String _assigned_membership = '';
  late String _phone = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
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
      List<dynamic> responseData = jsonDecode(response.body);
      if (responseData.isNotEmpty) {
        for (var userData in responseData) {
          if (userData['id'].toString() == id) {
            setState(() {
              _username = userData['username'] ?? '';
              _email = userData['email'] ?? '';
              // _assigned_membership = userData['assigned_membership'].toString();
              _phone = userData['phone'] ?? '';
              _isLoading = false;
            });
            return; 
          }
        }
        print('No se encontró ningún usuario con el ID proporcionado');
      } else {
        print('No se encontraron datos de usuario');
      }
    } else {
      print('Error al obtener los datos del usuario');
    }
  } catch (e) {
    print('Error de conexión: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  CustomFielDataNoScreen(title: 'Usuario: ', name: _username),
                  const Divider(),
                  CustomFielDataNoScreen(title: 'Email: ', name: _email),
                  const Divider(),
                  // CustomFielDataNoScreen(title: 'Membresia: ', name: _assigned_membership),
                  // const Divider(),
                  CustomFielDataNoScreen(title: 'Celular: ', name: _phone),
                ],
              ),
      ),
    );
  }
}

class CustomFielDataNoScreen extends StatelessWidget {
  final String title;
  final String name;

   CustomFielDataNoScreen({required this.title, required this.name});

  @override
Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.all(4.0),
      child: Padding(
        padding:  const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: FontStyle.titleTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  name,
                  style: FontStyle.descriptionTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}