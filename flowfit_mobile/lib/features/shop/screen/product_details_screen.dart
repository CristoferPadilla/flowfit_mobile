import 'package:flowfit_mobile/features/shop/widgets/buttons/custom_button.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
class ProductDetailsScreen extends StatelessWidget {
  final String name;
  final String description;
  final String imagePath;
  final String price;

  const ProductDetailsScreen({
    Key? key,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_rounded),
          ),
          iconTheme: const IconThemeData(color: PrimaryTheme.secundaryColor),
          title: const Text(
            'TIENDA',
            style: TextStyle(
                color: PrimaryTheme.secundaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: ProductDetailsBody(
          name: name,
          description: description,
          imagePath: imagePath,
          price: price,
        ),
      ),
    );
  }
}

class ProductDetailsBody extends StatefulWidget {
  final String name;
  final String description;
  final String imagePath;
  final String price;

  const ProductDetailsBody({
    Key? key,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
  }) : super(key: key);

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  int quantity = 0;

  void updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(widget.imagePath),
            ),
          ),
        ),
        SizedBox(
          height: 130,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Text(
                  widget.description,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: Column(
            children: [
              const Text('Cantidad:'),
              QuantifyButton(
                onQuantityChanged: updateQuantity,
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: const [
               BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxSh
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: const Border(top: BorderSide(color: Colors.grey)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Total a pagar',style: FontStyle.titleTextStyle.copyWith(fontSize: 20)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _PriceTotalWidget(
                      price: widget.price,
                      quantity: quantity,
                    ),
                  ),
                  const CustomButton()
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QuantifyButton extends StatelessWidget {
  final ValueChanged<int>? onQuantityChanged;

  const QuantifyButton({Key? key, this.onQuantityChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (QuantifyButtonState.quantity > 0) {
              QuantifyButtonState.quantity--;
              onQuantityChanged?.call(QuantifyButtonState.quantity);
            }
          },
        ),
        const SizedBox(width: 20),
        Text(
          '${QuantifyButtonState.quantity}',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            QuantifyButtonState.quantity++;
            onQuantityChanged?.call(QuantifyButtonState.quantity);
          },
        ),
      ],
    );
  }
}

class QuantifyButtonState {
  static int quantity = 0;
}

class _PriceTotalWidget extends StatelessWidget {
  final String price;
  final int quantity;

  const _PriceTotalWidget({
    Key? key,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double priceDouble = double.tryParse(price) ?? 0.0;
    double totalPrice = priceDouble * quantity;
    String formattedTotalPrice = totalPrice.toStringAsFixed(2);

    return Text(
      '\$ $formattedTotalPrice',
      style: FontStyle.titleTextStyle.copyWith(fontSize: 20),
    );
  }
}