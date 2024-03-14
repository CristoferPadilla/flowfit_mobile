import 'dart:convert';
import 'package:flowfit_mobile/features/first-steps/widget/title/custom_title.dart';
import 'package:flowfit_mobile/features/home/widget/navbar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileFormScreen extends StatefulWidget {
  const ProfileFormScreen({Key? key});

  @override
  ProfileFormScreenState createState() => ProfileFormScreenState();
}

class ProfileFormScreenState extends State<ProfileFormScreen> {
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _imcController = TextEditingController(text: '0.00'); // Inicialización aquí

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
    _weightController.addListener(_actualizarIMC);
    _heightController.addListener(_actualizarIMC);
  }

void _actualizarIMC() {
  setState(() {
    String weightString = _weightController.text;
    String heightString = _heightController.text;

    double weight = double.tryParse(weightString) ?? 0.0;
    double height = double.tryParse(heightString) ?? 0.0;

    // Si la altura es menor que 3, asumimos que se ingresó en metros
    if (height < 3) {
      height *= 100; // Convertimos a centímetros
    }

    // Se calcula el IMC
    double imc = calcularIMC(weight, height);

    _imcController.text = imc.toStringAsFixed(2);
  });
}
  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _imcController.dispose();
    super.dispose();
  }

  double calcularIMC(double peso, double estatura) {
    return peso / (estatura * estatura);
  }

  Future<void> enviarDatosAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? userId = prefs.getString('id');

    String weight = _weightController.text;
    String height = _heightController.text;
    double peso = double.parse(weight);
    double estatura = double.parse(height);

    String url = 'https://api-zydf.onrender.com/members/$userId';

    try {
      double imc = calcularIMC(peso, estatura);
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, dynamic>{
          'weight': weight,
          'height': height,
          'body_fat_percentage': imc.toStringAsFixed(2), 
        }),
      );

      if (response.statusCode == 200) {
        print('Datos de peso, estatura e IMC enviados correctamente a la API');
      } else {
        print('Error al enviar los datos de peso, estatura e IMC a la API');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomTitleSteps(
                title: '¡Maximicemos tu experiencia!',
                description: 'Ayúdanos a conocerte un poco más para poder ofrecerte la mejor experiencia de entrenamiento. Por favor, completa el siguiente cuestionario para conocerte un poco más.',
              ),
              const SizedBox(height: 20),
              const Text('Sobre ti', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              _buildTextField(label: 'Peso en Kg', controller: _weightController),
              _buildTextField(label: 'Estatura en metros', controller: _heightController),
              // _buildIMCTextField(),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  enviarDatosAPI();
                   Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const NavBar(),
          inheritTheme: true,
          ctx: context,
        ),
      );
                },
                child: const Text('Enviar Datos'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }

  // Widget _buildIMCTextField() {
  //   double imc = _weightController.text.isEmpty || _heightController.text.isEmpty
  //       ? 0.0
  //       : double.tryParse(_imcController.text) ?? 0.0;

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  //     child: TextField(
  //       readOnly: true,
  //       controller: _imcController,
  //       decoration: InputDecoration(
  //         labelText: 'IMC',
  //         border: const UnderlineInputBorder(),
  //       ),
  //     ),
  //   );
  // }
}
