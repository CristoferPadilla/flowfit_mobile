import 'package:flowfit_mobile/resources/themes/primary_theme.dart';
import 'package:flutter/material.dart';
import 'package:flowfit_mobile/resources/themes/font_styles.dart';

class CustomFielData extends StatelessWidget {
  final String title;
  final String name;
  final Widget screen;

  const CustomFielData({
    Key? key,
    required this.title,
     required this.name, required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => screen,
                ),
              );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 1,
          color: PrimaryTheme.secundaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: FontStyle.titleTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      name,
                      style: FontStyle.descriptionTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){},
                  child: const Icon(Icons.navigate_next_outlined, color: Colors.white,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
