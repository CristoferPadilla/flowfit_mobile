import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_platform_interface/stripe_platform_interface.dart';


class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _productIdController = TextEditingController();
  final _quantityController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryMonthController = TextEditingController();
  final _expiryYearController = TextEditingController();
  final _cvvController = TextEditingController();
    Future<void> createPurchase() async {
    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(
              email: "",
              name: "Carlos",
              phone: "09876543",
              address: Address(city: 'CDMX', country: "MEXICO", line1: "line1", line2: "line2", postalCode: "postalCode", state: "state")
            ),
          ),
        ),
      );

      if (paymentMethod != null) {
        final response = await http.post(
          Uri.parse('https://api-zydf.onrender.com/purchases/member'),
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzA5MzA5NzEzLCJleHAiOjE3MDkzMTMzMTN9.hF82IBX-3CsqsUTmntyD5itVN-g9iXsSQ8sqOFvN2dk', // replace with your actual token
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'purchase': {
              'product_id': _productIdController.text,
              'quantity': _quantityController.text,
              'purchase_date': DateTime.now().toIso8601String().substring(0, 10),
            },
            'stripeToken': paymentMethod.id,
          }),
        );

        if (response.statusCode == 200) {
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Purchase created!')),
          );
        } else {
          throw Exception('Failed to create purchase');
        }
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stripe Demo App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _productIdController,
              decoration: const InputDecoration(labelText: 'Product ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _cardNumberController,
              decoration: const InputDecoration(labelText: 'Card Number'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expiryMonthController,
                    decoration: const InputDecoration(labelText: 'Exp. Month'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _expiryYearController,
                    decoration: const InputDecoration(labelText: 'Exp. Year'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    decoration: const InputDecoration(labelText: 'CVV'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: createPurchase,
              child: const Text('Create Purchase'),
            ),
          ],
        ),
      ),
    );
  }
}