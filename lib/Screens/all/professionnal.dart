import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';

class ProfessionalScreen extends StatelessWidget {
  const ProfessionalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      scrollDirection: Axis.vertical,
      children: [
        if (DataCommon.mainCharacter.currentlyLearning != null)
          ListTile(
            leading: const Icon(Icons.menu_book_rounded),
            title: Text(DataCommon.mainCharacter.currentlyLearning!.nom),
            tileColor: Colors.grey[200],
          ),
        ListTile(
          leading: const Icon(Icons.menu_book_rounded),
          title: const Text("Education"),
          onTap: () => Navigator.pushNamed(context, '/education'),
        ),
        ListTile(
          leading: const Icon(Icons.wallet_travel),
          title: const Text("Jobs"),
          onTap: () => Navigator.pushNamed(context, '/jobs'),
        ),
        ListTile(
          leading: const Icon(Icons.star_border_outlined),
          title: const Text("Special Career"),
          onTap: () => Navigator.pushNamed(context, '/specialcareers'),
        )
      ],
    ));
  }
}
