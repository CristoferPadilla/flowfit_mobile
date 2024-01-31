import 'package:flowfit_mobile/features/home/screens/home_screen.dart';
import 'package:flowfit_mobile/features/login/widget/text/title_text.dart';
import 'package:flowfit_mobile/features/login/widget/textfield/custome_textfield.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
            ),
              Positioned(
                top: height * 0.1,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: PrimaryTheme.backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    color: Colors.white,
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
                  const CustomeTextTitle(
                    title: 'FlowFit',
                    size: 40,
                  ),
                  const SizedBox(height: 50),
                  const CustomeTextTitle(title: 'Iniciar sesión', size: 20),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        const CustomeTextField(
                          title: 'Usuario',
                          type: TextInputType.text,
                          isPassword: false,
                        ),
                        const SizedBox(height: 20),
                        const CustomeTextField(
                          title: 'Contraseña',
                          type: TextInputType.visiblePassword,
                          isPassword: true,
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '¿Olvidaste tu contraseña?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const HomeScreen(),
                                    inheritTheme: true,
                                    ctx: context),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Iniciar sesión',
                              style:
                                  TextStyle(color: PrimaryTheme.backgroundColor),
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
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Regístrate',
                                style: TextStyle(
                                  color: Colors.white,
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
      ),
    );
  }
}
