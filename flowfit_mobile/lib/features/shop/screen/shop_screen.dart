import 'package:flowfit_mobile/features/shop/widgets/custome_container/custome_container.dart';
import 'package:flowfit_mobile/features/shop/widgets/gridview/gridview_shop.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listaDeOpciones = [
      "Fecha",
      "Precio",
    ];

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Icon(Icons.shopping_bag),
        iconTheme: const IconThemeData(color: PrimaryTheme.secundaryColor),
        title: Text('TIENDA',
            style: FontStyle.titleTextStyle
                .copyWith(color: PrimaryTheme.secundaryColor, fontSize: 30)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Productos',
                  style: FontStyle.titleTextStyle.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: [
                  const Text('Ordenar por',
                      style: TextStyle(color: Colors.black)),
                  DropdownButton<String>(
                    items: listaDeOpciones.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                    icon: const Icon(Icons.arrow_drop_down,
                        color: PrimaryTheme.secundaryColor),
                    underline:
                        Container(), // Para eliminar la línea debajo del menú desplegable
                  ),
                ],
              ),
            ],
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CustomeCategoryContainer(
                  title: 'Todos',
                  color: PrimaryTheme.secundaryColor,
                ),
                CustomeCategoryContainer(
                  title: 'Bebidas',
                  color: PrimaryTheme.secundaryColor,
                  icon: Icons.local_drink_outlined,
                ),
                CustomeCategoryContainer(
                  title: 'Ropa',
                  color: PrimaryTheme.secundaryColor,
                  icon: Icons.person,
                ),
                CustomeCategoryContainer(
                  title: 'Proteina',
                  color: PrimaryTheme.secundaryColor,
                  icon: Icons.local_drink_outlined,
                ),
              ],
            ),
          ),
          const GridViewShop()
        ],
      ),
    ));
  }
}
