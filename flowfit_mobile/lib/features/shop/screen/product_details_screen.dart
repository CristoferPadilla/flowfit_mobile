import 'package:flutter/material.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_rounded)),
        iconTheme: const IconThemeData(color: PrimaryTheme.secundaryColor),
        title: Text('TIENDA',
            style: FontStyle.titleTextStyle
                .copyWith(color: PrimaryTheme.secundaryColor, fontSize: 30)),
      ),
      body: Column(
        children: [
          Container(
            height: 280,
            width: double.infinity,
              color: Colors.red,
          ),
          Container(
            height: 130,
            width: double.infinity,
              color: Colors.blue,
          ),
          Container(
            height: 100,
            width: double.infinity,
              color: Colors.green,
          ),
          const Spacer(),
          Card(
            color: Colors.cyan,
            child: Row(
              children: [
                const Text('300'),
                ElevatedButton(onPressed: (){}, child: const Text('Añadir al carrito'))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
