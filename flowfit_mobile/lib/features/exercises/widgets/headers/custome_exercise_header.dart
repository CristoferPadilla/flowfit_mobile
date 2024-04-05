import 'package:flowfit_mobile/resources/themes/font_styles.dart';
import 'package:flutter/material.dart';

class CustomExerciseHeader extends StatelessWidget {
  final String name;
  const CustomExerciseHeader({
    super.key, required this.appResource, required this.name,
  });

  final String appResource;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(appResource),
          fit: BoxFit.cover,
          opacity: .5
        ),
        // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
      ),
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back,color: Colors.white, size: 30,)),
            Column(
              children: [
                Text('RUTINA', style: FontStyle.titleTextStyle.copyWith(color: Colors.white),),
                Text(name, style: FontStyle.subtitleTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w400),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}