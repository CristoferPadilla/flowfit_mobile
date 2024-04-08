import 'package:flowfit_mobile/features/profile/screens/edit_info_screen.dart';
import 'package:flowfit_mobile/features/profile/widget/container/container_info.dart';
import 'package:flowfit_mobile/features/profile/widget/icon/icon_profile_stack.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class ConfigAccountScreen extends StatefulWidget {
  const ConfigAccountScreen({Key? key}) : super(key: key);

  @override
  State<ConfigAccountScreen> createState() => _ConfigAccountScreenState();
  
}

class _ConfigAccountScreenState extends State<ConfigAccountScreen> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: PrimaryTheme.secundaryColor,
          onPressed: () {
                                  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditUserInfoScreen())
            );
          },
          label: const Icon(Icons.edit, color: Colors.white),
        ),
        appBar: AppBar(
          title: const Text('Configuración de cuenta'),
        ),
        body: Column(
          children: [
            const IconProfileStack(isEdit: false),
            ContainerInfo(),
          ],
        ),
      ),
    );
  }
}
