import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Model/Carreer/job_offer.dart';

class ActualJob extends StatelessWidget {
  const ActualJob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    JobOffer actualJobOffer = DataCommon.mainCharacter.actualJobOffer!;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        ListTile(
          leading: actualJobOffer.entreprise.milieu.icon,
          title: Text(
              actualJobOffer.poste.nom + " • " + actualJobOffer.entreprise.nom),
        )
      ]),
    );
  }
}
