import 'package:flowfit_mobile/features/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


void main() {
  
 WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51OounUGf0J9y3KivIqzJpSV92NDZilojutUMqd6rARztgpcAjrNxpSmvZksj8uaaUj0XCTDY7eaWvh3MS4CX9I3300fnLmtcoI'; 
  runApp(MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
