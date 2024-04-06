import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flowfit_mobile/features/login/screen/login_screen.dart';
import 'package:flowfit_mobile/features/profile/screens/config_sccount_screen.dart';
import 'package:flowfit_mobile/features/profile/widget/icon/icon_profile_stack.dart';
import 'package:flowfit_mobile/features/profile/widget/textfield/custom_textfield.dart';
import 'package:flowfit_mobile/features/scanner/screen/scanner_screen.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final loadedUsername = prefs.getString('username') ?? '';
    setState(() {
      username = loadedUsername;
      isLoading = false;
    });
  }
   Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastLoginTime');
    await prefs.setBool('isLoggedIn', false);

    // Redirecciona a la pantalla de inicio de sesión
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MobileScannerScreen(),
              ),
            );
          },
          backgroundColor: PrimaryTheme.secundaryColor,
          child: const Icon(Icons.qr_code_scanner_outlined, color: Colors.white,),
        ),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              CustomeAppbar(
                title: 'Miembro',
                subtitle: 'Mi perfil de miembro',
              ),
              Padding(padding: EdgeInsets.all(8.0)),
            ],
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const IconProfileStack(isEdit: false ,),
                  Center(
                    child: Text(
                      username.isNotEmpty ? username : 'Loading...',
                      style: FontStyle.titleTextStyle,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (username.isNotEmpty)
                    const CustomFieldData(
                      title: 'Configuración de la cuenta ',
                      icon: Icons.navigate_next_outlined,
                      name: '',
                      screen: ConfigAccountScreen(),

                    ),
                     CustomFieldData(
                      title: 'Cerrar sesión',
                      icon: Icons.logout,
                      name: '',
                      screen: LoginScreen(),
                        onTap: () {
    logout();
  },
                    ),
                ],
              ),
      ),
    );
  }
}
