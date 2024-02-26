import 'package:flowfit_mobile/core/domain/responses/login_response.dart';
import 'package:flutter/material.dart';
import 'package:flowfit_mobile/core/data/data_source/remote/authentication_api.dart';
import 'package:flowfit_mobile/core/data/helpers/http.dart';
import 'package:flowfit_mobile/core/data/repositories_impl/repositories_implementatio.dart';
import 'package:flowfit_mobile/core/domain/repositories/authentication_repository.dart';
import 'package:flowfit_mobile/features/first-steps/screens/first_steps.dart';
import 'package:flowfit_mobile/features/login/widget/text/title_text.dart';
import 'package:flowfit_mobile/features/login/widget/textfield/custome_textfield.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final http = Http(baseUrl: 'https://api-zydf.onrender.com');
    final AuthenticationRepository auth =
        AuthenticationRepositoryImplementation(
      AuthenticationAPI(http),
    );

    final username = _usernameController.text;
    final password = _passwordController.text;

    auth.login(username, password).then((loginResponse) async {
  switch (loginResponse) {
    case LoginResponse.ok:
      print('Autenticación exitosa');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);

      final accessToken = prefs.getString('accessToken') ?? '';
      print('AccessToken: $accessToken');
      final id = prefs.getString('id') ?? '';
      print('Id member: $id');

      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const FirstStepsScreen(),
          inheritTheme: true,
          ctx: context,
        ),
      );
      break;
        case LoginResponse.accesDenied:
          print('Credenciales inválidas');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text(
                    'Credenciales inválidas. Por favor, inténtelo de nuevo.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          break;
        case LoginResponse.networkError:
          print('Error de red durante el inicio de sesión');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text(
                    'Hubo un error de red durante el inicio de sesión. Por favor, inténtelo de nuevo.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          break;
        case LoginResponse.unknownError:
          print('Error desconocido durante el inicio de sesión');
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text(
                    'Hubo un error desconocido durante el inicio de sesión. Por favor, inténtelo de nuevo.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          break;
      }
    });
  }

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
              child: SingleChildScrollView(
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
                          CustomeTextField(
                            title: 'Usuario',
                            type: TextInputType.text,
                            isPassword: false,
                            controller: _usernameController,
                          ),
                          const SizedBox(height: 20),
                          CustomeTextField(
                            title: 'Contraseña',
                            type: TextInputType.visiblePassword,
                            isPassword: true,
                            controller: _passwordController,
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
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Iniciar sesión',
                                style: TextStyle(
                                    color: PrimaryTheme.backgroundColor),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Todo esto es para iniciar sin internet
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const FirstStepsScreen(),
                                      inheritTheme: true,
                                      ctx: context,
                                    ),
                                  );
                                },
                                child: const Text(
                                  '¿No tienes una cuenta?',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
