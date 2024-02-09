import 'package:flutter/material.dart';
import 'package:flowfit_mobile/features/first-steps/widget/buttons/section_buttons.dart';
import 'package:flowfit_mobile/features/first-steps/widget/title/custom_title.dart';
import 'package:flowfit_mobile/features/home/widget/navbar/navbar.dart';

class ProfileFormScreen extends StatefulWidget {
  const ProfileFormScreen({Key? key}) : super(key: key);

  @override
  _ProfileFormScreenState createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    _ageController = TextEditingController();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
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
              _buildTextField(label: 'Edad', controller: _ageController),
              _buildTextField(label: 'Peso', controller: _weightController),
              _buildTextField(label: 'Estatura', controller: _heightController),
              const SizedBox(height: 30,),
              const SectionButtons(isBackButtonVisible: false, screen: NavBar(), isFrontButtonVisible: true),
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
}
