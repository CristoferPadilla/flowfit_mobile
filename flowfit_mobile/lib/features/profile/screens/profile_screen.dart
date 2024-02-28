import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flowfit_mobile/features/profile/screens/config_sccount_screen.dart';
import 'package:flowfit_mobile/features/profile/widget/icon/icon_profile_stack.dart';
import 'package:flowfit_mobile/features/profile/widget/textfield/custom_textfield.dart';
import 'package:flowfit_mobile/features/scanner/screen/scanner_screen.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
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
            const IconProfileStack(isEdit: false,),
             Center(child: Text('member', style: FontStyle.titleTextStyle,)),
            const SizedBox(height: 20),
            const CustomFielData(
              title: 'Configuración de la cuenta ',
              name: '',
              screen:ConfigAccountScreen(),)
          ],
        ),
      ),
    );
  }
}

