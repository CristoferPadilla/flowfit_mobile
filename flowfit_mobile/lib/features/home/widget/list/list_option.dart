import 'package:flowfit_mobile/features/home/widget/containers/option_containers.dart';
import 'package:flutter/material.dart';

class ListOption extends StatelessWidget {
  const ListOption({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height * 0.55,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (context, index) {
            return const OptionContainer();
          },
        ),
      ),
    );
  }

}