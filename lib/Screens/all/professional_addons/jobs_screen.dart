import 'package:flutter/material.dart';

import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_carreer.dart';
import 'package:minilife/Model/Carreer/job_offer.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StaticCarreer.updatePreviousPoste(StaticCarreer.computerScienceCarreer);
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            if (DataCommon.mainCharacter.age < StaticCarreer.minAgeTravail ||
                DataCommon.mainCharacter.isLearning)
              const ListTile(
                leading: Icon(Icons.school_outlined),
                title: Text("You are not able to get a job."),
              ),
            for (int i = 0; i < StaticCarreer.jobOffer.length; i++)
              ListTile(
                leading: StaticCarreer.jobOffer[i].entreprise.milieu.icon,
                title: Text(StaticCarreer.jobOffer[i].poste.nom),
                subtitle: Text(StaticCarreer.jobOffer[i].entreprise.nom +
                    " • " +
                    StaticCarreer.jobOffer[i].salaire.toString() +
                    "k €"),
                onTap: () {
                  if (DataCommon.mainCharacter.age >=
                          StaticCarreer.minAgeTravail &&
                      !DataCommon.mainCharacter.isLearning) {
                    JobOffer offer = StaticCarreer.jobOffer[i];
                    String schoolRequirements = offer.poste.requirement == null
                        ? "none"
                        : offer.poste.requirement!.nom;
                    String proRequirement = offer.poste.previousPoste == null
                        ? "none"
                        : offer.poste.previousPoste!.nom;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text(offer.poste.nom),
                              content: Text("Company : " +
                                  offer.entreprise.nom +
                                  "\nAnnual Salary : " +
                                  offer.salaire.toString() +
                                  "k €\nSchool Requirements : " +
                                  schoolRequirements +
                                  "\nProfessionnal Experience : " +
                                  proRequirement),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    DataCommon.mainCharacter
                                        .jobInterview(offer);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Take an interview'),
                                ),
                              ],
                            ));
                  }
                },
              )
          ],
        ));
  }
}
