import 'package:flowfit_mobile/features/profile/screens/edit_info_screen.dart';
import 'package:flowfit_mobile/features/profile/widget/container/container_info.dart';
import 'package:flowfit_mobile/features/profile/widget/icon/icon_profile_stack.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class ConfigAccountScreen extends StatelessWidget {
    final String? imageUrl;

  const ConfigAccountScreen({Key? key, this.imageUrl}) : super(key: key);

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
            IconProfileStack(isEdit: false,profile_picture: imageUrl,),
            ContainerInfo(),
          ],
        ),
      ),
    );
  }
}
