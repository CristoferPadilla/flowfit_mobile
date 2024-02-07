import 'package:flowfit_mobile/features/exercises/widgets/list/body_part_lisr.dart';
import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class BodyPartScreen extends StatelessWidget {
  const BodyPartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child:  Scaffold(
        backgroundColor: PrimaryTheme.backgroundColor.withOpacity(0.9),
        appBar: const PreferredSize(
                    preferredSize: Size.fromHeight(90),
          child: CustomeAppbar(
            title: 'Partes del cuerpo',
            subtitle: '¡Encuentra el mejor ejercicio para ti!',
            
          ),
        ),
        body: Column(
          children: [
            BodyPartList()
          ],
        ),
        
      ),
    );
  }
}