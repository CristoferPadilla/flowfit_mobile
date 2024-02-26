import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flowfit_mobile/features/scanner/screen/scanner_screen.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: IconButton.filled(
            iconSize: 40,
            style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(PrimaryTheme.secundaryColor)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MobileScannerScreen(),
                ),
              );
            },
            icon: const Icon(Icons.qr_code_scanner_outlined)),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Stack(alignment: Alignment.topRight, children: [
            CustomeAppbar(
              title: 'Miembro',
              subtitle: 'Mi perfil de miembro',
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            )
          ]),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.bottomCenter, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 128, 128, 128),
                        border: Border.fromBorderSide(BorderSide(
                            color: PrimaryTheme.secundaryColor, width: 3)),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/profile_example.jpg',
                          fit: BoxFit.cover,
                          width: 150,
                          height: 150,
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 100),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: PrimaryTheme.secundaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 20),
            const CustomFielData(
              title: 'Nombre: ',
              name: 'Cristofer Padilla',
            ),
            const CustomFielData(
              title: 'Email: ',
              name: 'cristoferpadilla0406@gmail.com',
            ),
            const CustomFielData(
              title: 'Nivel: ',
              name: 'Principiante',
            ),
            // const Row(
            //   children: [
            //     CustomFielData(
            //       title: 'Edad: ',
            //       name: '20',
            //     ),
            //     CustomFielData(
            //       title: 'Peso: ',
            //       name: '70',
            //     ),
            //     CustomFielData(
            //       title: 'Estatura: ',
            //       name: '1.60',
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class CustomFielData extends StatelessWidget {
  final String title;
  final String name;

  const CustomFielData({
    Key? key,
    required this.title,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 1,
        color: PrimaryTheme.secundaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: FontStyle.titleTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    name,
                    style: FontStyle.descriptionTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: (){},
                child: const Icon(Icons.navigate_next_outlined, color: Colors.white,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
