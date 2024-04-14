// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';
import 'package:flowfit_mobile/features/analytics/widgets/list/list_calendary.dart';
import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flowfit_mobile/features/home/widget/card/membership_card.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({Key? key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
    final controller = CardFormEditController();
  @override
  void initState() {
    controller.addListener(update);
    super.initState();
  }

  void update() => setState(() {});
  @override
  void dispose() {
    controller.removeListener(update);
    controller.dispose();
    super.dispose();
}
  Map<String, dynamic>? paymentIntent; 
  
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: CustomeAppbar(
            title: '', 
            subtitle: '¡Hoy es un gran día para entrenar',
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const MembershipCard(
              startDate: '05 de abril de 2024',
              validUntil: '07 de mayo de 2024',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await makePayment();
                  },
                  child: const Text(
                    'Renovar Membresía',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                // Container(
                //   width: 300,
                //   height: 700,
                //   child: CardFormField(
                //     style: CardFormStyle(
                //       backgroundColor: Colors.white,
                //       textColor: Colors.black,
                //       cursorColor:Colors.black,
                //       placeholderColor: PrimaryTheme.secundaryColor,
                //       borderColor: PrimaryTheme.secundaryColor,
                //     ),
                    
                //       onCardChanged: (card) {
                //      controller: controller;
                //   if(controller.details.complete == true)
                //     ElevatedButton(
                //       onPressed: _handlePayPress,
                //       child: Text('Pay'),
                //     );
                //       },
                          
                //   ),
                // )
              ],
            ),
            
          ],
        ),
      ),
    );
  }
  
// Future<void> _handlePayPress() async{
//   await Stripe.instance.confirmPayment(
//     data: 
//       PaymentMethodParams.card(
//         paymentMethodData: PaymentMethodData(

//           billingDetails: BillingDetails(

//           ),
//         ),
      
//     ),
//      paymentIntentClientSecret: 'clientSecret',
// );
// }
  Future<void> makePayment() async { 
    try { 
      // Create payment intent data 

      //todo este es el default
      paymentIntent = await createPaymentIntent('250','MXN');
      //todo este es para la api
      // paymentIntent = await  createPaymentAPI();

      await Stripe.instance.initPaymentSheet( 
        paymentSheetParameters: SetupPaymentSheetParameters( 
          // Client secret key from payment data 
          paymentIntentClientSecret: paymentIntent!['client_secret'], 
          allowsDelayedPaymentMethods: true,
          googlePay: const PaymentSheetGooglePay( 
              // Currency and country code is accourding to India 
              testEnv: true, 
              currencyCode: "MXN", 
              merchantCountryCode: "MX",


              ), 
          // Merchant Name 
          customerId: Stripe.stripeAccountId,
          merchantDisplayName: 'Flutterwings', 
          // intentConfiguration: IntentConfiguration(
          //   mode: IntentMode(currencyCode: currencyCode, amount: amount)
          // )
          // return URl if you want to add 
          // returnURL: 'flutterstripe://redirect', 
        ), 
        
      ); 
      // Display payment sheet 
      displayPaymentSheet(

      ); 
    } catch (e) { 
      print("exception $e"); 
  
      if (e is StripeConfigException) { 
        print("Stripe exception ${e.message}"); 
      } else { 
        print("exception $e"); 
      } 
    } 
  } 
  
  displayPaymentSheet() async { 
    try { 
      // "Display payment sheet"; 
      await Stripe.instance.presentPaymentSheet(); 
      
      // Show when payment is done 
      // Displaying snackbar for it 
      ScaffoldMessenger.of(context).showSnackBar( 
        const SnackBar(content: Text("Paid successfully")), 
      ); 
              print('paymentResult');

      paymentIntent = null; 
    } on StripeException catch (e) { 
      // If any error comes during payment  
      // so payment will be cancelled 
      print('Error: $e'); 
  
      ScaffoldMessenger.of(context).showSnackBar( 
        const SnackBar(content: Text(" Payment Cancelled")), 
      ); 
    } catch (e) { 
      print("Error in displaying"); 
      print('$e'); 
    } 
  } 

   createPaymentAPI() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final memberId = prefs.getString('id') ?? '';
      final assignedMembership = prefs.getString('assigned_membership') ?? '';
      final isStripe = true; 
      final Map<String, String> env = dotenv.env;
      final stripeToken = env['STRIPE_PUBLISH'];
      final accessToken = prefs.getString('accessToken') ?? '';

      final response = await http.put(
        Uri.parse('https://api-zydf.onrender.com/members/renew/$memberId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'memberId':memberId,
          "membershipId": assignedMembership,
            // "isStripe": isStripe,
          'stripeToken':stripeToken ,
          
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('Resultado de renovación: $result');
      } else {
        print('Error al renovar la membresía: ${response.statusCode}');
        print('Error al renovar la membresía: ${response.body}');
        print('Error al renovar la membresía: ${response.reasonPhrase}');
      }
    } catch (err) {
      print('Error al renovar la membresía: $err'); 
    }
  }

  createPaymentIntent(String amount, String currency) async { 
    try { 
      Map<String, dynamic> body = { 
        'amount': ((int.parse(amount)) * 100).toString(), 
        'currency': currency, 
        'payment_method_types[]': 'card', 
      }; 
            final Map<String, String> env = dotenv.env;
      final secretKey = env['STRIPE_SECRET'];

      var response = await http.post( 
        Uri.parse('https://api.stripe.com/v1/payment_intents'), 
        headers: { 
          'Authorization': 'Bearer $secretKey', 
          'Content-Type': 'application/x-www-form-urlencoded'
        }, 
        body: body, 
      ); 
      print('Payment Intent Body: ${response.body.toString()}'); 
      return jsonDecode(response.body.toString()); 
    } catch (err) { 
      print('Error charging user: ${err.toString()}'); 
    } 
  }



}

