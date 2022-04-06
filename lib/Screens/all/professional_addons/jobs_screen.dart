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
                DataCommon.mainCharacter.isLearning ||
                DataCommon.mainCharacter.retired)
              ListTile(
                tileColor: Colors.grey[200],
                leading: const Icon(Icons.cancel),
                title: const Text("You are not able to get a job."),
              ),
            if (DataCommon.mainCharacter.actualJobOffer != null)
              ListTile(
                leading: DataCommon
                    .mainCharacter.actualJobOffer!.entreprise.milieu.icon,
                title: Text(DataCommon.mainCharacter.actualJobOffer!.poste.nom +
                    " • " +
                    DataCommon.mainCharacter.actualJobOffer!.entreprise.nom),
                subtitle: Text("Performance : " +
                    DataCommon.mainCharacter.performancePro.toString() +
                    " %"),
                tileColor: Colors.grey[200],
              ),
            if (DataCommon.mainCharacter.listFormations.isNotEmpty ||
                DataCommon.mainCharacter.career.isNotEmpty)
              ListTile(
                tileColor: Colors.grey[200],
                leading: const Icon(Icons.book),
                title: const Text("Curriculum Vitae"),
                onTap: () => Navigator.pushNamed(context, '/cv'),
              ),
            if (DataCommon.mainCharacter.actualJobOffer != null &&
                DataCommon.mainCharacter.canWorkHarder)
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text("Work Harder !"),
                onTap: () {
                  DataCommon.mainCharacter.workharder();
                  Navigator.pop(context, true);
                },
                tileColor: Colors.grey[200],
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
                      !DataCommon.mainCharacter.isLearning &&
                      !DataCommon.mainCharacter.retired) {
                    JobOffer offer = StaticCarreer.jobOffer[i];
                    String schoolRequirements = offer.poste.requirement == null
                        ? "none"
                        : offer.poste.requirement!.nom;
                    String proRequirement = offer.poste.previousPoste == null
                        ? "none"
                        : offer.poste.previousPoste!.nom;
                    showDialog(
                        context: context,
                        builder: (BuildContext context2) => AlertDialog(
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
                                      Navigator.pop(context2, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    DataCommon.mainCharacter
                                        .jobInterview(offer);
                                    Navigator.pop(
                                      context2,
                                    );
                                    Navigator.pop(context, true);
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
