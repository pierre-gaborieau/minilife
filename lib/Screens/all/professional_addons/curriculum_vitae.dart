import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Model/Carreer/job_offer.dart';
import 'package:minilife/Model/School/formation.dart';

class CurriculumVitae extends StatelessWidget {
  const CurriculumVitae({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          for (Formation f in DataCommon.mainCharacter.listFormations)
            ListTile(
              leading: const Icon(Icons.school),
              title: Text(f.nom),
            ),
          for (JobOffer offer in DataCommon.mainCharacter.career)
            ListTile(
              leading: offer.entreprise.milieu.icon,
              title: Text(offer.poste.nom + " • " + offer.entreprise.nom),
              subtitle: Text(offer.yearsInPost.toString() + " years"),
            )
        ],
      ),
    );
  }
}
