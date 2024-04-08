import 'package:flowfit_mobile/features/analytics/widgets/list/list_calendary.dart';
import 'package:flowfit_mobile/features/home/widget/appbar/custome_appbar.dart';
import 'package:flowfit_mobile/features/home/widget/list/list_option.dart';
import 'package:flowfit_mobile/features/profile/widget/icon/icon_profile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: CustomeAppbar(
            title: '', 
            subtitle: '¡Hoy es un gran día para entrenar',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              ListCalendary(),
              ListOption(),
            ],
          ),
        ),
      ),
    );
  }
}
