import 'package:flowfit_mobile/features/exercises/widgets/list/body_part_lisr.dart';
import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flutter/material.dart';

class BodyPartScreen extends StatelessWidget {
  const BodyPartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child:  Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: const PreferredSize(
                    preferredSize: Size.fromHeight(90),
          child: CustomeAppbar(
            title: 'Rutinas de ejercicios',
            subtitle: 'Selecciona que parte de tu cuerpo quieres ejercitar',
            
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