import 'package:flowfit_mobile/features/analytics/widgets/list/list_calendary.dart';
import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flowfit_mobile/features/home/widget/list/list_option.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: CustomeAppbar(
            title: '', 
            subtitle: '¡Hoy es un gran día para entrenar',
          ),
        ),
        body: const SingleChildScrollView(
          child:  Column(
            children: [
              ListCalendary(),
              //   MembershipCard(
              //   startDate: '30 de Marzo de 2024' ,
              //   validUntil: '30 de Abril de 2024',
              // ),
              ListOption()
            ],
          ),
        ),
      ),
    );
  }
}
