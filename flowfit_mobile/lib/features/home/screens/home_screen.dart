import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flowfit_mobile/features/home/widget/list/list_calendary.dart';
import 'package:flowfit_mobile/features/home/widget/list/list_option.dart';
import 'package:flowfit_mobile/features/profile/widget/icon/icon_profile.dart';
// import 'package:flowfit_mobile/features/home/widget/navbar/navbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        // bottomNavigationBar: NavBar() ,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
            CustomeAppbar(title: 'Febrero',subtitle: '¡Hoy es un gran día para entrenar',),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: IconProfile(),
            )
          ]),
        ),
        body: Column(
          children: [
            ListCalendary(),
            ListOption(),
          ],
        ),
      ),
    );
  }
}
