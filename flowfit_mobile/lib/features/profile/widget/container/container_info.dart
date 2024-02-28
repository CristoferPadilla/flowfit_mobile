import 'package:flowfit_mobile/features/profile/widget/textfield/custom_textfield_noscreen.dart';
import 'package:flutter/material.dart';

class ContainerInfo extends StatelessWidget {
  const ContainerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          children: [
            CustomFielDataNoScren(
              title: 'Usuario: ',
              name:'member' ,
            ),
            Divider(),
            CustomFielDataNoScren(
              title: 'Contraseña: ',
              name:'*******' ,
            ),
                        Divider(),
            CustomFielDataNoScren(
              title: 'Email: ',
              name:'member@exemple.com' ,
            ),
            Divider(),
            CustomFielDataNoScren(
              title: 'Membresia: ',
              name:'Normal' ,
            ),
                        Divider(),
            CustomFielDataNoScren(
              title: 'Celular: ',
              name:'99912347873' ,
            ),
        ],),
      ),
    );
  }
}