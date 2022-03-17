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
            subtitle: Text("Performance : " +
                DataCommon.mainCharacter.performancePro!.toString() +
                " %"),
          ),
        if (DataCommon.mainCharacter.actualJobOffer != null)
          ListTile(
            leading:
                DataCommon.mainCharacter.actualJobOffer!.entreprise.milieu.icon,
            title: Text(DataCommon.mainCharacter.actualJobOffer!.poste.nom +
                " • " +
                DataCommon.mainCharacter.actualJobOffer!.entreprise.nom),
            subtitle: Text("Performance : " +
                DataCommon.mainCharacter.performancePro!.toString() +
                " %"),
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
