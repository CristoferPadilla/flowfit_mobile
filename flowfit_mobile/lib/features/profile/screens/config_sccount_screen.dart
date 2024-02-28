import 'package:flowfit_mobile/features/profile/widget/container/container_info.dart';
import 'package:flowfit_mobile/features/profile/widget/icon/icon_profile_stack.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class ConfigAccountScreen extends StatelessWidget {
  const ConfigAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: PrimaryTheme.secundaryColor,
          onPressed: (){

        }, label: const Icon(Icons.edit, color: Colors.white,)),
        appBar: AppBar(
          title: const Text('Configuración de cuenta'),
        ),
        body:  const Column(
          children: [
             IconProfileStack(isEdit: false,),
             ContainerInfo()
          ],
        )
      ),
    );
  }
}