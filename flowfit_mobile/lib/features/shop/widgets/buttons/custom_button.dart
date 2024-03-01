import 'package:flowfit_mobile/features/shop/screen/purchase_product_screen.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  PaymentPage()
,
                ),
              );
        },
        child: Container(
          height:80 ,
          width: 200 ,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: PrimaryTheme.secundaryColor,
          ),
          child: Center(child: Text('Comprar',style: FontStyle.titleTextStyle.copyWith(color: Colors.white, fontSize: 25),)),
        ),
      ),
    );
  }
}