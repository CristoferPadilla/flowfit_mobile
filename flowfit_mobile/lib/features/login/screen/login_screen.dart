import 'package:flowfit_mobile/features/login/widget/text/title_text.dart';
import 'package:flowfit_mobile/features/login/widget/textfield/custome_textfield.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isTextFieldClicked = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            color: PrimaryTheme.secundaryColor.withOpacity(0.9),
          ),
          if (!isTextFieldClicked)
            Positioned(
              top: height * 0.1,
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: PrimaryTheme.backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.fitness_center,
                  color: PrimaryTheme.secundaryColor.withOpacity(0.8),
                  size: 80,
                ),
              ),
            ),
          Container(
            height: height * 0.7,
            decoration: const BoxDecoration(
              color: PrimaryTheme.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(65),
                topRight: Radius.circular(65),
              ),
              boxShadow: [
                BoxShadow(
                  color: PrimaryTheme.backgroundColor,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const CustomeTextTitle(title: 'FlowFit', size: 40,),
                const SizedBox(height: 50),
                const CustomeTextTitle(title: 'Iniciar sesión', size: 20),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      const CustomeTextField(title: 'Usuario', type:TextInputType.text, isPassword: false,),
                      const SizedBox(height: 20),
                      const CustomeTextField(title: 'Contraseña', type: TextInputType.visiblePassword, isPassword: true,),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: PrimaryTheme.secundaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PrimaryTheme.secundaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Iniciar sesión',
                            style: TextStyle(
                              color: PrimaryTheme.backgroundColor
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '¿No tienes una cuenta?',
                            style: TextStyle(
                              color: PrimaryTheme.secundaryColor,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Regístrate',
                              style: TextStyle(
                                color: PrimaryTheme.secundaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
