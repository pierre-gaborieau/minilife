import 'dart:math';

import 'package:minilife/Data/data_entreprises.dart';
import 'package:minilife/Data/static_formations.dart';
import 'package:minilife/Data/static_milieu.dart';
import 'package:minilife/Model/Carreer/carreer.dart';
import 'package:minilife/Model/Carreer/entreprise.dart';
import 'package:minilife/Model/Carreer/job_offer.dart';
import 'package:minilife/Model/Carreer/poste.dart';

class StaticCarreer {
  static void updatePreviousPoste(Carreer carreer) {
    for (int i = 0; i < carreer.listPoste!.length; i++) {
      if (i > 0) {
        carreer.listPoste![i].previousPoste =
            carreer.listPoste![i - 1].previousPoste;
      }
    }
  }

  static int minAgeTravail = 16;

  static Carreer computerScienceCarreer =
      Carreer("Computer Science", StaticMilieu.milieuTechnology, [
    Poste(
        nom: "Code Tester",
        salaireMin: 18,
        salaireMax: 22,
        requirement: StaticFormations.formationComputerScience,
        previousPoste: null),
    Poste(
        nom: "Junior Developper",
        salaireMin: 25,
        salaireMax: 35,
        requirement: StaticFormations.formationComputerScience,
        previousPoste: null),
    Poste(
        nom: "Senior Developper",
        salaireMin: 33,
        salaireMax: 60,
        requirement: StaticFormations.formationComputerScience,
        previousPoste: null)
  ]);
  static List<JobOffer> jobOffer = [];

  static void regenerateJobOffer() {
    jobOffer.clear();
    jobOffer = [
      generateOffer(computerScienceCarreer, DataEntreprise.computerList),
      generateOffer(computerScienceCarreer, DataEntreprise.computerList),
      generateOffer(computerScienceCarreer, DataEntreprise.computerList),
      generateOffer(computerScienceCarreer, DataEntreprise.miniComputerList),
      generateOffer(computerScienceCarreer, DataEntreprise.miniComputerList),
      generateOffer(computerScienceCarreer, DataEntreprise.miniComputerList),
      generateOffer(computerScienceCarreer, DataEntreprise.miniComputerList),
      generateOffer(computerScienceCarreer, DataEntreprise.miniComputerList),
      generateOffer(computerScienceCarreer, DataEntreprise.miniComputerList),
      generateOffer(computerScienceCarreer, DataEntreprise.miniComputerList),
    ];
  }

  static JobOffer generateOffer(Carreer wanted, List<Entreprise> entreprises) {
    Poste tmp = wanted.listPoste![Random().nextInt(wanted.listPoste!.length)];
    JobOffer offer = JobOffer(
        entreprise: entreprises[Random().nextInt(entreprises.length)],
        poste: tmp,
        salaire: nextInt(tmp.salaireMin, tmp.salaireMax));
    return offer;
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
